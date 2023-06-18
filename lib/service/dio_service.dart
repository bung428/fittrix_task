import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioService {
  static final DioService instance = DioService._();

  final dio = Dio();

  DioService._() {
    dio.interceptors.add(logInterceptorsWrapper);
  }

  static InterceptorsWrapper get logInterceptorsWrapper =>
      InterceptorsWrapper(onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handler,
          ) {
        final sb = StringBuffer();
        sb.writeln('DioService REQ ${options.method} ${options.path}');
        if (options.queryParameters.isNotEmpty) {
          sb.writeln('queryParameters : ${options.queryParameters}');
        }
        if (options.data != null) {
          sb.write('data : ${options.data}');
        }
        if (kDebugMode) {
          print(sb);
        }
        handler.next(options);
      }, onResponse: (Response e, ResponseInterceptorHandler handler) {
        if (kDebugMode) {
          print(
              'DioService RES ${e.requestOptions.method} ${e.requestOptions.path}');
          print('DioService RES data : ${e.data}');
        }
        handler.next(e);
      }, onError: (DioException e, ErrorInterceptorHandler handler) {
        if (kDebugMode) {
          print(
              'DioService ERROR ${e.requestOptions.method} ${e.requestOptions.path} ${e.error} ${e.message}');
        }
        handler.next(e);
      });
}
