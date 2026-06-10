import '../user.dart';

/// Абстрактный репозиторий (Domain Layer)
///
/// Определяет контракт, который должна реализовать Data Layer.
/// Это позволяет легко менять источник данных (API → Mock → Local DB и т.д.)
abstract class UserRepository {
  /// Получить список пользователей с пагинацией
  Future<List<User>> getUsers({int page = 1});
}
