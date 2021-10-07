import 'dart:io';

import 'oss_const.dart';

class RequestMessage {
  String? endpoint;
  String? bucketName;
  HttpMethod method;
  bool? isAuthorizationRequired;
  String? uploadPath;
  String? savePath;
  String? authorization;
  ContentType? contentType;
  String? objectKey;

  RequestMessage(
      {this.endpoint,
      this.bucketName,
      required this.method,
      this.isAuthorizationRequired,
      this.uploadPath,
      this.savePath,
      this.authorization,
      this.contentType,
      this.objectKey});
}
