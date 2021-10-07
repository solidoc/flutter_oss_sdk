class OssToken {
  String tempAk;
  String tempSk;
  String securityToken;
  String expiration;

  OssToken(
      {required this.tempAk,
      required this.tempSk,
      required this.securityToken,
      required this.expiration});

  static OssToken fromJson(Map<String, dynamic> json) {
    return OssToken(
        expiration: json['Expiration'],
        tempAk: json['AccessKeyId'],
        tempSk: json['AccessKeySecret'],
        securityToken: json['SecurityToken']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AccessKeyId'] = this.tempAk;
    data['AccessKeySecret'] = this.tempSk;
    data['SecurityToken'] = this.securityToken;
    data['Expiration'] = this.expiration;
    return data;
  }
}
