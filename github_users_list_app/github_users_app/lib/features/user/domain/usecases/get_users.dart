import 'package:equatable/equatable.dart';

import '../repositories/user_repository.dart';
import '../user.dart';

/// UseCase: Получение списка пользователей
///
/// Согласно Clean Architecture, UseCase — это бизнес-логика приложения.
/// Здесь мы инкапсулируем логику получения пользователей с пагинацией.
class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  /// Выполнение UseCase
  ///
  /// [params] — параметры запроса (страница)
  Future<List<User>> call(GetUsersParams params) async {
    return await repository.getUsers(page: params.page);
  }
}

/// Параметры для UseCase
class GetUsersParams extends Equatable {
  final int page;
  final int perPage;

  const GetUsersParams({
    this.page = 1,
    this.perPage =
        20, // GitHub API по умолчанию возвращает 30, мы ограничиваем 20
  });

  @override
  List<Object?> get props => [page, perPage];
}
