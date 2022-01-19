import 'package:ntp/ntp.dart';

class NtpTime {
  int _offset = 0;
  static NtpTime? ins;
  NtpTime._();

  static Future<int> getNtpOffset() async {
    int? offset;
    try {
      offset = await NTP.getNtpOffset(
          lookUpAddress: "ntp.aliyun.com", timeout: Duration(seconds: 2));
    } catch (e) {
      print("getNtpOffset-ali error: $e");
    }
    if (offset != null) return offset;
    try {
      offset = await NTP.getNtpOffset(timeout: Duration(seconds: 2));
    } catch (e) {
      print("getNtpOffset-def error: $e");
    }
    return offset ?? 0;
  }

  static Future<NtpTime> getInstance() async {
    if (ins != null) return ins!;
    var offset = await getNtpOffset();
    var newIns = NtpTime._();
    newIns._offset = offset;
    ins = newIns;
    return ins!;
  }

  DateTime now() {
    var localTime = DateTime.now();
    try {
      return localTime.add(Duration(milliseconds: _offset));
    } catch (e) {
      return localTime.toLocal();
    }
  }

  int timeStamp() {
    return now().millisecondsSinceEpoch ~/ 1000;
  }
}

class NtpTimeTool {
  static Future<DateTime> now() async {
    return (await NtpTime.getInstance()).now();
  }

  static Future<int> timeStamp() async {
    return (await NtpTime.getInstance()).timeStamp();
  }
}
