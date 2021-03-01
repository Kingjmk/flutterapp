import 'package:app/services/services.dart';
import 'package:app/exceptions/exceptions.dart';
import 'package:app/models/models.dart';
import 'package:dio/dio.dart';
import 'package:app/config.dart' as config;
import 'dart:convert';
import 'package:app/services/storage.dart';

abstract class BaseAuthenticationService {
  String loginUrl = '${config.baseUrl}/auth/login';
  String refreshUrl = '${config.baseUrl}/auth/refresh';
  String USER_KEY = 'UserData';
  Future<User> getCurrentUser();
  Future<User> login(String email, String password);
  Future<User> refreshToken(User user);
  Future<void> signOut();
}

class AuthenticationService extends BaseAuthenticationService {

  @override
  Future<User> getCurrentUser() async {
    var data = await StorageService.read(USER_KEY) ?? null;
    if (data == null) return null;
    return User.fromJson(json.decode(data));
  }

  Future<User> updateUser(User user, {bool fetch: false}) async {
    if (fetch) {
      // if pull is True fetch new data from API
    }

    // Set new user data into prefs
    await StorageService.write(USER_KEY, json.encode(user.toJson()));
    return user;
  }

  @override
  Future<User> login(String email, String password) async {
    Response res;
    try {
      res = await GuestApiService.post(loginUrl, data: {'email': email, 'password': password});
    } on DioError catch (e) {
      if (e.response == null) throw AuthenticationException(message: 'Please check your network connection.');

      switch (e.response.statusCode) {
        case 400:
          throw AuthenticationException(message: 'Wrong username or password.');
          break;
        case 403:
        case 401:
          throw AuthenticationException(message: 'Too many retries, please try again later.');
          break;
        default:
          throw AuthenticationException(message: 'Something terribly wrong must have happened.');
          break;
      }
    }
    return updateUser(User.fromJson(res.data), fetch: false);
  }

  @override
  Future<User> refreshToken(User user) async {
    Response res = await GuestApiService.post(refreshUrl, data: {'refresh': user.token.refreshToken});
    Token token = Token.fromJson(res.data);
    user.token = token;
    updateUser(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    StorageService.delete(USER_KEY);
    return null;
  }
}
