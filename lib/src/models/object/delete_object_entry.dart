//删除objects
class DeleteObjectsRequest {
  List<String> objectKeys;
  String bucketName;
  bool isAuthorizationRequired = true;

  DeleteObjectsRequest(this.objectKeys, this.bucketName);
}
