import 'package:delivery/common/const/data.dart';
import 'package:delivery/common/secure_storage/secure_storage..dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final dioProvider = Provider<Dio>(
  (ref) {
    final dio = Dio();
    final storage = ref.watch(secureStorageProvider);
    dio.interceptors.add(
      CustomInterceptor(storage: storage),
    );
    return dio;
  },
);

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });
  /*
   * 1) 요청 보낼때
   * 요청이 보내질떄마다
   * 만약에 요청의 header에 accessToken : true라는 값이 있다면
   * 실제 토큰을 가져와서 (storage에서) authorization : bearer token으로
   * 헤더를 변경한다.
   */
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ][${options.method}] ${options.uri}');
    if (options.headers['accessToken'] == 'true') {
      //헤더삭제
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      //실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      //헤더삭제
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      //실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer  $token',
      });
    }

    // TODO: implement onRequest
    return super.onRequest(options, handler);
  }

  // 2) 응답 받을때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES][${response.requestOptions.method}] ${response.requestOptions.uri}');
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  /*
   * 3) 에러 났을때
   * 401에러가 났을때 (status code)
   * 토큰을 재발급 받는 시도를 하고 토큰이 재발급 되면
   * 다시 새로운 토큰으로 요청 
   */
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print('[ERR][${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    //refreshToken 완전히 없으면 에러를 던진다.
    if (refreshToken == null) {
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final resp = await dio.post('http://$ip/auth/token',
            options:
                Options(headers: {'authorization': 'Bearer $refreshToken'}));

        final accessToken = resp.data['accessToken'];

        final options = err.requestOptions;

        //토큰 변경
        options.headers.addAll({'authorization': 'Bearer $accessToken'});

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        //요정 재전송
        final response = await dio.fetch(options);

        return handler.resolve(response);
      } catch (e) {
        return handler.reject(err);
      }
    }
    return handler.reject(err);
  }
}
