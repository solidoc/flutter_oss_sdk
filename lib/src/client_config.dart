import 'auth/authorization_provider.dart';

///OssClient配置类
class ClientConfig {
  AuthorizationProvider? authorizationProvider;
  String endPoint;
  String bucket;
  int connectTimeout;
  int receiveTimeout;

  ClientConfig(
      {this.authorizationProvider,
      required this.endPoint,
      required this.bucket,
      required this.connectTimeout,
      required this.receiveTimeout});
}
