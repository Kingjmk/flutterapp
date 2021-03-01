import 'package:dio/dio.dart';
import 'package:app/config.dart' as config;
import 'package:app/services/authentication.dart';

AuthenticationService _authService = AuthenticationService();

BaseOptions options = new BaseOptions(
  baseUrl: config.baseUrl,
  connectTimeout: 30000,
  receiveTimeout: 27000,
);

// Authenticated
Dio ApiService = new Dio(options)..interceptors.add(JWTInterceptor());

class JWTInterceptor extends Interceptor {
  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = new Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return ApiService.request<dynamic>(requestOptions.path, data: requestOptions.data, queryParameters: requestOptions.queryParameters, options: options);
  }

  Future<void> refreshToken() async {
    var currentUser = await _authService.getCurrentUser();
    await _authService.refreshToken(currentUser);
  }

  Future<RequestOptions> onRequest(RequestOptions options) async {
    var currentUser = await _authService.getCurrentUser();
    options.headers["Authorization"] = "Bearer ${currentUser.token.accessToken}";
    return options;
  }

  Future onError(DioError err) async {
    if (err.response?.statusCode != 401) return err; //TODO: Logout user

    await this.refreshToken();
    return _retry(err.request);
  }
}

// Unauthenticated
Dio GuestApiService = new Dio(options);
