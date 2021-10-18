//删除objects
class DeleteObjectsRequest {
  List<ObjectKey> objectKeys;
  String bucketName;
  bool isAuthorizationRequired = true;

  DeleteObjectsRequest(this.objectKeys, this.bucketName);
}

class ObjectKey {
  String key;
  String versionId;

  ObjectKey(this.key, this.versionId);
}
