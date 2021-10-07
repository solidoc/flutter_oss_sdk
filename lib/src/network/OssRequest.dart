import 'dart:io';

///Oss请求封装类
class OssRequest {
  String method;
  dynamic data;
  String url;
  Map<String, dynamic> headers = {};
  String bucket;
  String objectKey;
  ContentType contentType;
  OssRequest(
      {required this.method,
      this.data,
      required this.url,
      required this.headers,
      required this.bucket,
      required this.objectKey,
      required this.contentType});
}
