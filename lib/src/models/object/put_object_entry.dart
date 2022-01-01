///上传Object
class PutObjectRequest {
  String objectKey;
  String uploadFilePath;
  String? bucketName;
  bool isAuthorizationRequired = false;
  PutObjectRequest(this.objectKey, this.uploadFilePath,
      {String? bucketName, bool? isAuthorizationRequired = false}) {
    this.isAuthorizationRequired = isAuthorizationRequired ?? false;
    this.bucketName = bucketName;
  }
}

class PutObjectResponse {
  String url;
  String xOssVersionId;

  PutObjectResponse(this.url, this.xOssVersionId);

  static PutObjectResponse fromJson(Map<String, dynamic> json) {
    return PutObjectResponse(json['url'], json['xOssVersionId']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['xOssVersionId'] = this.xOssVersionId;
    return data;
  }
}
