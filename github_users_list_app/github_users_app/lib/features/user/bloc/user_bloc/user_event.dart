import 'package:equatable/equatable.dart';

/// Базовый класс для всех событий BLoC
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

/// Событие загрузки первой страницы пользователей
class LoadUsers extends UserEvent {
  final int page;

  const LoadUsers({this.page = 1});

  @override
  List<Object> get props => [page];
}

/// Событие загрузки следующей страницы (пагинация)
class LoadMoreUsers extends UserEvent {
  final int page;

  const LoadMoreUsers({required this.page});
}
