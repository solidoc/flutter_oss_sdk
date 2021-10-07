import 'package:flutter_oss_sdk/src/models/object/get_object_entry.dart';
import 'package:flutter_oss_sdk/src/models/object/put_object_entry.dart';
import 'package:flutter_oss_sdk/src/models/oss_const.dart';
import 'package:flutter_oss_sdk/src/models/request_message.dart';
import 'package:flutter_oss_sdk/src/network/content_type_utils.dart';
import 'package:flutter_oss_sdk/src/network/oss_call.dart';
import 'package:flutter_oss_sdk/src/network/oss_response.dart';

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
    call.execute(
        callback: (OssResponse result) {
          if (result.code == 200) {
            PutObjectResponse response = PutObjectResponse(result.url);
            onSucceed(response);
          } else {
            onFailed("upload failed,error code : ${result.code}");
          }
        },
        onProgress: onProgress,
        onReceiverProgress: onProgress,
        path: '');
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
    call.execute(
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
}
