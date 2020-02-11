import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor{
  int _maxCharLine = 200;

  Future onRequest(RequestOptions options) {
    print('--> ${options.method} ${options.path}');
    print('Connect type: ${options.contentType}');
    print('<-- END HTTP');
    return super.onRequest(options);
  }

  Future onResponse(Response response) {
    print('<-- ${response.statusCode} ${response.request.method} ${response.request.path}');
    String resData = response.data.toString();
    if (resData.length > _maxCharLine) {
      int iterations = (resData.length / _maxCharLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endIndex = i * _maxCharLine + _maxCharLine;
        if (endIndex > resData.length) {
          endIndex = resData.length;
        }
        print(resData.substring(i * _maxCharLine, endIndex));
      }
    } else {
      print(response.data);
    }
    print('<-- END HTTP');
    return super.onResponse(response);
  }

  Future onError(DioError err) {
    print("<-- Error -->");
    print(err.error);
    print(err.message);
    return super.onError(err);
  }
}