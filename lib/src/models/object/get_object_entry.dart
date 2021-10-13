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

///head object
class HeadObjectRequest {
  String objectKey;
  String bucketName;
  bool isAuthorizationRequired = true;
  HeadObjectRequest(this.objectKey,
      {required this.bucketName, bool isAuthorizationRequired = true}) {
    this.isAuthorizationRequired = isAuthorizationRequired;
  }
}
