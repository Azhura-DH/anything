import 'package:anything/model/user_response.dart';
import 'package:anything/utils/logging_interceptor.dart';
import 'package:dio/dio.dart';

class UserApiProvider {
  final String _endpoint = "https://randomuser.me/api";
  Dio _dio;

  UserApiProvider() {
    BaseOptions options = BaseOptions(
      receiveTimeout: 5000,
      connectTimeout: 5000,
    );
    _dio = Dio(options);
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<UserResponse> getUser() async {
    try {
      Response res = await _dio.get(_endpoint);
      return UserResponse.fromJson(res.data);
    } catch(e, stacktrace) {
      print('Exception Occured : $e stacktrace : $stacktrace');
      return UserResponse.withError(_handleError(e));
    }
  }

  String _handleError(DioError dioError) {
    String errorDescription = "";
    if (dioError is DioError) {
      switch (dioError.type) {
        case DioErrorType.CANCEL:
          errorDescription = 'Request to API server was cancelled';
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = 'Connection timeout with API server';
          break;
        case DioErrorType.DEFAULT:
          errorDescription = 'API server failed due to internet connection';
          break;
        case DioErrorType.RESPONSE:
          errorDescription = 'Recived invalid status code: ${dioError.response.statusCode}';
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = 'Send timeout with connection with API server';
          break;
        default:
      }
    } else {
      errorDescription = 'Unexpected error occured';
    }
    return errorDescription;
  }
}
