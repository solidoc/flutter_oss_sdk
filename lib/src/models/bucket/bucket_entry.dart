import '../oss_const.dart';

///bucket信息
class BucketEntry {
  //Bucket创建时间
  String creationDate;
  //Bucket访问的外网域名
  String extranetEndpoint;
  //同区域ECS访问Bucket的内网域名
  String intranetEndpoint;
  //Bucket所在的数据中心
  String location;
  //Bucket名称
  String name;
  //Bucket存储类型，支持Standard、IA、Archive三种存储类型
  StorageClass storageClass;

  BucketEntry(
      {required this.creationDate,
      required this.extranetEndpoint,
      required this.intranetEndpoint,
      required this.location,
      required this.name,
      required this.storageClass});
}
