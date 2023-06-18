// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:fittrix_task/model/const/exercise_type.dart';
import 'package:fittrix_task/model/record_model.dart';
import 'package:fittrix_task/service/auth_service.dart';
import 'package:fittrix_task/service/data/http_state.dart';
import 'package:fittrix_task/service/dio_service.dart';

const baseUrl = 'https://648bd1ee8620b8bae7ebd395.mockapi.io';

class ApiService {
  static final ApiService _instance = ApiService._();

  static ApiService get instance => _instance;

  ApiService._();

  final _dio = Dio(BaseOptions(baseUrl: baseUrl));

  void init() {
    _dio.interceptors.add(DioService.logInterceptorsWrapper);
  }

  Future<List<RecordModel>> getExerciseRecords(
      ExType type, int page, {int limit = 10}) async {
    List<RecordModel> list = [];
    final userId = AuthService.instance.model?.id;
    if (userId == null) {
      return [];
    }
    try {
      final res = await _dio.get(
          '/exercises',
          queryParameters: {
            'page': page,
            'limit': limit,
            'type': type.typeName,
            'user_id': userId,
            'sortBy': 'date',
            'order': 'desc',
          }
      );
      if (res.data == null) {
        return list;
      }
      List data = res.data;
      for (final record in data) {
        list.add(RecordModel.fromJson(record));
      }
      print('ApiService : getExerciseRecords : records : ${list.length}');

      return list;
    } catch (e) {
      print('ApiService : getExerciseRecords : exception $e');
    }
    return list;
  }

  Future<HttpState> saveRecord(RecordModel model) async {
    try {
      final res = await _dio.post('/exercises', data: model.toJson());
      print('ApiService : saveRecord : model : ${model.toJson()}');
      final statusCode = res.statusCode;
      if (statusCode == 201 || res.data != null) {
        return HttpState.success;
      } else {
        return HttpState.fail;
      }
    } catch (e) {
      print('ApiService : saveRecord : exception $e');
    }
    return HttpState.fail;
  }
}