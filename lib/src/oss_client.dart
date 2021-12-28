import 'dart:io';

import 'package:dio/dio.dart';

import 'auth/oss_request_signer.dart';
import 'auth/oss_token.dart';
import 'client_config.dart';
import 'models/oss_const.dart';
import 'models/request_message.dart';
import 'network/OssRequest.dart';
import 'network/content_type_utils.dart';
import 'network/oss_call.dart';
import 'oss_utils.dart';
import 'service/base_service.dart';
import 'service/bucket_service.dart';
import 'service/object_service.dart';

///oss 封装类
class OssClient with ObjectService, BucketService implements BaseService {
  ClientConfig _config;
  late Dio _dio;

  OssClient(this._config) {
    _initDio();
  }

  void _initDio() {
    int connectTimeout = _config.connectTimeout;
    int receiveTimeout = _config.receiveTimeout;
    String baseUrl =
        OssUtils.buildUrlWithBucket(_config.bucket, _config.endPoint);
    BaseOptions options = BaseOptions(
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        baseUrl: baseUrl);
    _dio = Dio(options);
    // _dio.interceptors
    //     .add(LogInterceptor(requestBody: false, responseBody: true));
  }

  @override
  Future<OssCall> newCall(RequestMessage requestMessage) async {
    OssRequest request = await createOssRequest(requestMessage);
    OssCall call = OssCall(request, _dio);
    return call;
  }

  Future<OssRequest> createOssRequest(RequestMessage requestMessage) async {
    Map<String, dynamic> header = {
      HttpHeaderKey.CONTENT_TYPE: requestMessage.contentType ?? ''
    };
    requestMessage.headers?.forEach((String key, dynamic value) {
      header[key] = value;
    });
    //生成url
    var url = _buildUrl(requestMessage);
    //处理请求方法
    var method = _buildMethod(requestMessage);
    //处理上传文件
    var data = await _buildData(requestMessage, header);
    String bucket = requestMessage.bucketName ?? _config.bucket;
    var objectKey = requestMessage.objectKey ?? "";
    var contentType = requestMessage.contentType ?? ContentType.json;
    var headers = header;

    OssRequest request = OssRequest(
        method: method,
        data: data,
        url: url,
        headers: headers,
        bucket: bucket,
        objectKey: objectKey,
        contentType: contentType);

    //处理Authorization
    if (requestMessage.isAuthorizationRequired ??
        _config.authorizationProvider != null) {
      OssToken token = await _config.authorizationProvider!.getAuthorization();
      request.headers[HttpHeaderKey.X_OSS_SECURITY_TOKEN] = token.securityToken;
      OssRequestSigner signer = OssRequestSigner(token, request);
      String authorization = signer.sign();
      if (authorization.isNotEmpty) {
        request.headers[HttpHeaderKey.AUTHORIZATION] = authorization;
      }
    }
    return request;
  }

  ///获取url
  String _buildUrl(RequestMessage requestMessage) {
    String bucket = requestMessage.bucketName ?? _config.bucket;
    String resourcePath = requestMessage.objectKey!;
    String url = OssUtils.buildUrlWithBucket(bucket, _config.endPoint,
        resourcePath: resourcePath);
    // print("requestUrl=$url");
    return url;
  }

  ///获取Http method
  String _buildMethod(RequestMessage requestMessage) {
    HttpMethod method = requestMessage.method;
    assert(method != null);
    String methodStr;
    switch (method) {
      case HttpMethod.GET:
        methodStr = "GET";
        break;
      case HttpMethod.HEAD:
        methodStr = "HEAD";
        break;
      case HttpMethod.POST:
        methodStr = "POST";
        break;
      case HttpMethod.PUT:
        methodStr = "PUT";
        break;
      case HttpMethod.DELETE:
        methodStr = "DELETE";
        break;
    }
    return methodStr;
  }

  ///获取data
  Future<dynamic> _buildData(
      RequestMessage requestMessage, Map<String, dynamic> header) async {
    String? path = requestMessage.uploadPath;
    if (path != null && path.isNotEmpty) {
      File file = File(path);
      bool isExist = await file.exists();
      if (isExist) {
        header['Content-Type'] =
            ContentTypeUtils.getFileContentTypeString(path);
        return file.openRead();
      }
    } else {
      return requestMessage.data;
    }
  }
}
