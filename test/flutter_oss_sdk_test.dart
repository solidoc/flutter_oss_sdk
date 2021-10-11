import 'package:flutter_oss_sdk/flutter_oss_sdk.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test deleteMuti', () {
    // ClientConfig config = ClientConfig(
    //     endPoint: endPoint,
    //     bucket: bucket,
    //     authorizationProvider: KeypodProvider(),
    //     connectTimeout: 20000,
    //     receiveTimeout: 120000);
    // OssClient.init(config);
    // OssClient.instance.deleteObjects(request,
    //     onSucceed: onSucceed, onFailed: onFailed, onProgress: onProgress);
  });
}

class KeypodProvider implements AuthorizationProvider {
  @override
  Future<OssToken> getAuthorization() async {
    var sts = {
      "accessKeyId": "STS.NUnBh9MwLtC74awasuV6BCSwg",
      "accessKeySecret": "2E4BWrzR4jfTDaAHQG9PqM9zh827xXzsnzcfsjfDPb6K",
      "stsToken":
          "CAISxQJ1q6Ft5B2yfSjIr5bbCdKNoKhtw4HcNkfGhXMgWrlurJbchTz2IHBOfHBgB+Adt/k3mm9R5vgelqp6U4cdzP0d9GU3vPpt6gqET9frcaXXhOV2fPTHdEGXDxnkppGwB8zyUNLafNq0dlnAjVUd6LDmdDKkLSrHVJqSksxfc8gwVAu1ZiYkYdBNPVlNpdM9P3ncPurXAXyMuGfLC1dysQdRkH527b/FoveR8R3Dllb3uLh38o36OcqjdNI+fsU9AdS4zfRxeu3t8RQX5hUWqf8v1qcB8mydt5TBWlcJphyPa+CRrow1JQQgavhgQvdO67re7aQk67GLyN6skksUZbsJDXjlKdr+kJeeKoSALc0kcLv3AXPJ3+2UO4P92wFeOiJBbFoaJYp6cyIoV0N1Gm+GMM2k9UHSZQu+UKWfwEn0PEC3X+6CGoABZPMIWOEeqXb26Js+rxdH4WJEJSfjeXj4JsCW/YpTt1TCox5gIhcsnEdbFA2ZfJgXccUoODfuggIO1GqK4XGstqJfl3l0fi1pqifXzL4I9oqaFpv8yU7VOYIuLqhsugcLhvjo485u+lek5FLwU85YQ/Gfl8ekEi6DIShXfWbZXgg=",
      "expiration": "1633935977000"
    };
    return OssToken(
        tempAk: sts["accessKeyId"] as String,
        tempSk: sts["accessKeySecret"] as String,
        securityToken: sts["stsToken"] as String,
        expiration: sts["expiration"].toString());
  }
}
