import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:restaurant_mobile/common/const/data.dart';
import 'package:restaurant_mobile/common/const/dio.dart';
import 'package:restaurant_mobile/common/secure_storage/secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(CustomInterceptor(storage: storage));

  return dio;
});

class CustomInterceptor extends Interceptor {
  FlutterSecureStorage storage;

  CustomInterceptor({required this.storage});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      options.headers.addAll({'authorization': 'Bearer $token'});
    }

    if (options.headers['refreshToke'] == 'true') {
      options.headers.remove('refreshToke');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      options.headers.addAll({'authorization': 'Bearer $token'});
    }
    // TODO: implement onRequest
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      '[RES]: ${response.requestOptions.method} ${response.requestOptions.uri}',
    );
    // TODO: implement onResponse
    return super.onResponse(response, handler);
  }

  // 에러
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // TODO: implement onError
    // status code가 401인 경우
    print('onError: ${err.requestOptions.method} ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null) {
      return handler.reject(err);
    }

    final isStatusCode401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    if (isStatusCode401 && !isPathRefresh) {
      // 401 에러가 발생했을 때
      // refresh token을 이용해서 access token을 재발급 받는다.
      final dio = Dio();
      try {
        final res = await dio.post(
          '$ip/auth/token',
          options: Options(headers: {'authorization': 'Bearer $refreshToken'}),
        );

        final accessToken = res.data['accessToken'];

        final options = err.requestOptions;

        options.headers.addAll({'authorization': 'Bearer $accessToken'});

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        final response = await dio.fetch(options);

        return handler.resolve(response);
      } on DioException catch (e) {
        print('Error during token refresh: $e');
        return handler.reject(err);
      }
    }
  }
}
