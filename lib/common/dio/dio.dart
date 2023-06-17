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
    print('[RES] [${response.requestOptions.method}] [${response.requestOptions.uri}]');

    return super.onResponse(response, handler);
  }
  // 3) 에러가 났을때
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    // 401 에러가 났을 때(status code)
    // 토큰을 재발급 받는 시도를 하고, 토클이 재발급 되면
    // 다시 새로운 토큰으로 요청한다.
    print('[ERR] [${err.requestOptions.method}] [${err.requestOptions..uri}]');
    //if (err.response!.statusCode == 401)

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    if (refreshToken == null) {
      // 그냥 에러를 돌려준다.(refresh token 이 없을때 handler.reject를 사용
      handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final resp = await dio.post(
          'http://$ip/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            },
          ),
        );

        final accessToken = resp.data['accessToken'];

        final options = err.requestOptions;

        options.headers.addAll({
          'authorization': 'Bearer $accessToken',
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // Request 재요청(토큰만 변경해서 재요청) => 오류가 없었던 것처럼
        final response = await dio.fetch(options);

        return handler.resolve(response);

      } on DioError catch(e) {
        return handler.reject(e);
      }

      return handler.reject(err);
    }
  }


}