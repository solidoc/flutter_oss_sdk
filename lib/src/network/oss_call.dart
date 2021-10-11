import 'package:dio/dio.dart';

import 'OssRequest.dart';
import 'oss_response.dart';

class OssCall {
  OssRequest request;
  Dio dio;

  OssCall(this.request, this.dio);

  Future execute(
      {required Function(OssResponse result) callback,
      required Function(int count, int total) onProgress,
      required Function(int count, int total) onReceiverProgress,
      String? path}) async {
    Options options = Options();
    options.contentType = request.contentType.toString();
    options.method = request.method;
    if (request.headers != null) {
      options.headers = request.headers;
      options.headers?.forEach((String key, dynamic value) {
        print("$key=$value");
      });
    }
    Response response;
    OssResponse result = OssResponse(200, '', '');
    try {
      if (path == null || path.isEmpty) {
        response = await dio.request(request.url,
            data: request.data,
            options: options,
            onSendProgress: onProgress,
            onReceiveProgress: onReceiverProgress);
      } else {
        response = await dio.download(request.url, path,
            data: request.data,
            options: options,
            onReceiveProgress: onReceiverProgress);
      }
      result.code = response.statusCode ?? 200;
    } on DioError catch (e) {
      print("request error:${e.toString()}");
      result.code = 500;
      result.msg = e.response.toString();
    }
    result.url = request.url;
    callback(result);
  }

  Future<OssResponse> post() async {
    Options options = Options();
    options.contentType = request.contentType.toString();
    options.method = request.method;
    options.headers = request.headers;
    options.headers?.remove("Content-Type");
    options.headers?.forEach((String key, dynamic value) {
      print("$key=$value");
    });

    OssResponse result = OssResponse(204, '', '');
    try {
      Response response =
          await dio.post(request.url, data: request.data, options: options);
      result.code = response.statusCode ?? 500;
    } on DioError catch (e) {
      print("request-post error:${e.message}");
      result.code = e.response?.statusCode ?? 500;
      result.msg = e.response.toString();
    } catch (e) {
      print("-post error:$e");
    }
    result.url = request.url;
    return result;
  }
}
