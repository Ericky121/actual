import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../const/data.dart';

class CustomInterceptor extends Interceptor {

  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });
  // 1) 요청을 보낼때
  // 요청이 보내질 때마다
  // 만약에 요처의 Header 에 accessToken: true 라는 값이 있으면
  // 실제 토큰을 가져와서 (storage에서) authorization 에 넣는다.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] [${options.uri}]');

    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    super.onRequest(options, handler);
  }
  // 2) 응답을 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }
  // 3) 에러가 났을때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }


}