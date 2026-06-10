import 'package:dio/dio.dart';

import '../../../core/constants/app_constants.dart';
import '../models/user_model.dart';

/// Абстрактный источник данных (Data Layer)
abstract class UserRemoteDataSource {
  /// Получить список пользователей с GitHub API
  Future<List<UserModel>> getUsers({int page = 1});
}

/// Реализация источника данных через HTTP (Dio)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio _dio = Dio();

  @override
  Future<List<UserModel>> getUsers({int page = 1}) async {
    try {
      final response = await _dio.get(
        '${AppConstants.baseUrl}/users',
        queryParameters: {'per_page': AppConstants.perPage, 'page': page},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
