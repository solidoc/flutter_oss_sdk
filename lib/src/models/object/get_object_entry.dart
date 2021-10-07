///下载object
class GetObjectRequest {
  String objectKey;
  String path;
  String bucketName;
  bool isAuthorizationRequired = false;
  GetObjectRequest(this.objectKey, this.path,
      {required this.bucketName, bool? isAuthorizationRequired}) {
    this.isAuthorizationRequired = isAuthorizationRequired ?? false;
  }
}
