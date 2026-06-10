import 'package:dio/dio.dart';

import '../../../core/network/network_info.dart';
import '../../user/domain/repositories/user_repository.dart';
import '../../user/domain/user.dart';
import '../datasources/user_remote_data_source.dart';

/// Реализация репозитория (Data Layer)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<User>> getUsers({int page = 1}) async {
    if (await networkInfo.isConnected) {
      try {
        final users = await remoteDataSource.getUsers(page: page);
        return users; // Здесь можно добавить маппинг, если нужно
      } on DioException catch (e) {
        throw Exception('Ошибка сети: ${e.message}');
      } catch (e) {
        throw Exception('Неизвестная ошибка: $e');
      }
    } else {
      throw Exception('Нет подключения к интернету. Проверьте соединение.');
    }
  }
}
