import 'dart:convert';
import 'dart:developer';

import 'package:dependencies/dependencies.dart';

class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Fimber.i('===== REQUEST =====');
    Fimber.i('${options.method}: ${options.path}');
    Fimber.i('Headers: ${options.headers}');
    Fimber.i('Payload: ${options.data}');
    Fimber.i('===== REQUEST =====');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Fimber.i('===== RESPONSE =====');
    Fimber.i('${response.requestOptions.method}: ${response.requestOptions.path}  \nStatus: ${response.statusCode}');
    log('Data: ${jsonEncode(response.data)}');
    Fimber.i('===== RESPONSE =====');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Fimber.i('===== REQUEST ERROR =====');
    Fimber.i('${err.requestOptions.method}: ${err.requestOptions.path} \nError: ${err.response}');
    Fimber.i('===== REQUEST ERROR =====');
    return super.onError(err, handler);
  }
}