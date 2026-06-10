import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../features/data/datasources/user_remote_data_source.dart';
import '../../features/data/repositories/user_repository_impl.dart';
import '../network/network_info.dart';

import '../../features/user/domain/repositories/user_repository.dart';

// регистрация всех зависимостей через get_it
/// Service Locator (Dependency Injection)
final GetIt sl = GetIt.instance;

/// Инициализация всех зависимостей приложения
Future<void> initGetIt() async {
  // ==================== Core ====================
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));

  // ==================== Data Sources ====================
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );

  // ==================== Repositories ====================
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
}
