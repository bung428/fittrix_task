// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:fittrix_task/model/user_model.dart';
import 'package:fittrix_task/service/dio_service.dart';

const baseUrl = 'https://648bd1ee8620b8bae7ebd395.mockapi.io';

class AuthService {
  static final AuthService _instance = AuthService._();

  static AuthService get instance => _instance;

  AuthService._();

  UserModel? _model;
  UserModel? get model => _model;

  bool get isLogin => _model != null;

  final _dio = Dio(BaseOptions(baseUrl: baseUrl));

  void init() {
    _dio.interceptors.add(DioService.logInterceptorsWrapper);
  }

  Future<UserModel?> login(int pwd) async {
    try {
      final res = await _dio.get('/users', queryParameters: {'user': pwd});
      if (res.data == null) {
        return null;
      }
      List data = res.data;
      _model = UserModel.fromJson(data.first);
      print('AuthService : loginModel : ${model?.toJson()}');

      return _model;
    } catch (e) {
      print('AuthService : login : exception $e');
    }
    return null;
  }
}
