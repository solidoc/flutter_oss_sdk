import 'dart:convert';
import 'dart:io';

import 'package:flutter_oss_sdk/src/models/object/delete_object_entry.dart';
import 'package:flutter_oss_sdk/src/models/object/get_object_entry.dart';
import 'package:flutter_oss_sdk/src/models/object/put_object_entry.dart';
import 'package:flutter_oss_sdk/src/models/oss_const.dart';
import 'package:flutter_oss_sdk/src/models/request_message.dart';
import 'package:flutter_oss_sdk/src/network/content_type_utils.dart';
import 'package:flutter_oss_sdk/src/network/oss_call.dart';
import 'package:flutter_oss_sdk/src/network/oss_response.dart';
import 'package:crypto/crypto.dart';

import 'base_service.dart';

abstract class ObjectService implements BaseService {
  Future putObject(PutObjectRequest request,
      {required Function(PutObjectResponse result) onSucceed,
      required Function(String errMsg) onFailed,
      required Function(int count, int total) onProgress}) async {
    RequestMessage requestMsg = RequestMessage(
        bucketName: request.bucketName,
        objectKey: request.objectKey,
        uploadPath: request.uploadFilePath,
        method: HttpMethod.PUT,
        contentType: ContentTypeUtils.getContentType(request.uploadFilePath),
        isAuthorizationRequired: request.isAuthorizationRequired);
    OssCall call = await newCall(requestMsg);
    await call.execute(
        callback: (OssResponse result) {
          if (result.code == 200) {
            PutObjectResponse response = PutObjectResponse(result.url);
            onSucceed(response);
          } else {
            onFailed("upload failed,error code : ${result.code}");
          }
        },
        onProgress: onProgress,
        onReceiverProgress: onProgress);
  }

  Future getObject(GetObjectRequest request,
      {required Function() onSucceed,
      required Function(String errMsg) onFailed,
      required Function(int count, int total) onProgress}) async {
    RequestMessage requestMsg = RequestMessage(
        bucketName: request.bucketName,
        method: HttpMethod.GET,
        objectKey: request.objectKey,
        savePath: request.path,
        isAuthorizationRequired: request.isAuthorizationRequired);
    // requestMsg.contentType = ContentTypeUtils.getFileContentType(requestMsg.savePath);
    OssCall call = await newCall(requestMsg);
    await call.execute(
        callback: (OssResponse result) {
          if (result.code == 200) {
            onSucceed();
          } else {
            onFailed("download failed,error code : ${result.code}");
          }
        },
        onReceiverProgress: onProgress,
        path: requestMsg.savePath,
        onProgress: onProgress);
  }

  Future<OssResponse> deleteObjects(DeleteObjectsRequest request) async {
    var xml = '<?xml version="1.0" encoding="UTF-8"?><Delete>';
    var end = '</Delete>';
    xml += '<Quiet>true</Quiet>';
    request.objectKeys.forEach((key) {
      xml += '<Object><Key>' + key + '</Key></Object>';
    });
    xml += end;

    // body
    var data = xml;
    var md5Str = base64Encode(md5.convert(xml.codeUnits).bytes);
    var length = data.codeUnits.length;

    // headers
    var headers = {
      HttpHeaderKey.CONTENT_MD5: md5Str,
      'Content-Length': length,
    };

    RequestMessage requestMsg = RequestMessage(
        objectKey: "?delete",
        bucketName: request.bucketName,
        objectKeys: request.objectKeys,
        contentType: ContentType.parse("text/xml"),
        method: HttpMethod.POST,
        data: data,
        isAuthorizationRequired: request.isAuthorizationRequired,
        headers: headers);

    OssCall call = await newCall(requestMsg);
    return await call.post();
  }

  Future<Map<String, dynamic>> headObject(HeadObjectRequest request) async {
    RequestMessage requestMsg = RequestMessage(
      objectKey: request.objectKey,
      bucketName: request.bucketName,
      contentType: ContentType.parse("text/xml"),
      method: HttpMethod.HEAD,
      isAuthorizationRequired: request.isAuthorizationRequired,
    );
    OssCall call = await newCall(requestMsg);
    var response = await call.head();
    return response.headers.map;
  }
}
