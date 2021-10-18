class OssResponse {
  int code;
  String msg;
  String url;
  String xOssVersionId = '';

  OssResponse(this.code, this.msg, this.url, {String xOssVersionId = ''});
}
