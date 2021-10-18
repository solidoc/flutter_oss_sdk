///下载object
class GetObjectRequest {
  String objectKey;
  String versionId;
  String path;
  String bucketName;
  bool isAuthorizationRequired = false;
  GetObjectRequest(this.objectKey, this.versionId, this.path,
      {required this.bucketName, bool? isAuthorizationRequired}) {
    this.isAuthorizationRequired = isAuthorizationRequired ?? false;
  }
}

class GetObjectResponse {
  String xOssVersionId;

  GetObjectResponse(this.xOssVersionId);
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
