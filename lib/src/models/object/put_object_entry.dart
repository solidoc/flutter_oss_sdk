///上传Object
class PutObjectRequest {
  String objectKey;
  String uploadFilePath;
  String? bucketName;
  bool isAuthorizationRequired = false;
  PutObjectRequest(this.objectKey, this.uploadFilePath,
      {this.bucketName, bool? isAuthorizationRequired = false}) {
    this.isAuthorizationRequired = isAuthorizationRequired ?? false;
  }
}

class PutObjectResponse {
  String url;

  PutObjectResponse(this.url);

  static PutObjectResponse fromJson(Map<String, dynamic> json) {
    return PutObjectResponse(json['url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
