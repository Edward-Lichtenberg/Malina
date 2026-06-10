import 'package:equatable/equatable.dart';

import '../../domain/user.dart';

/// Базовый класс для всех состояний BLoC
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

/// Начальное состояние
class UserInitial extends UserState {}

/// Состояние загрузки
class UserLoading extends UserState {}

/// Успешное состояние с данными
class UserLoaded extends UserState {
  final List<User> users;
  final bool hasReachedMax; // Достигнут ли конец списка
  final int currentPage; // Текущая страница

  const UserLoaded({
    required this.users,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });

  /// Метод для обновления состояния при пагинации
  UserLoaded copyWith({
    List<User>? users,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return UserLoaded(
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object?> get props => [users, hasReachedMax, currentPage];
}

/// Состояние ошибки (включая отсутствие интернета)
class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
