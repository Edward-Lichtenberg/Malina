import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/get_users.dart';
import 'user_event.dart';
import 'user_state.dart';

/// BLoC для управления состоянием списка пользователей
class UserBloc extends Bloc<UserEvent, UserState> {
  late final GetUsers getUsers;

  UserBloc() : super(UserInitial()) {
    getUsers = GetUsers(GetIt.instance<UserRepository>());

    on<LoadUsers>(_onLoadUsers);
    on<LoadMoreUsers>(_onLoadMoreUsers);
  }

  /// Обработка начальной загрузки пользователей
  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());

    try {
      final users = await getUsers(GetUsersParams(page: event.page));

      emit(
        UserLoaded(
          users: users,
          currentPage: event.page,
          hasReachedMax:
              users.length < 20, // GitHub возвращает по 30, но мы используем 20
        ),
      );
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  /// Обработка подгрузки следующих пользователей (пагинация)
  Future<void> _onLoadMoreUsers(
    LoadMoreUsers event,
    Emitter<UserState> emit,
  ) async {
    if (state is UserLoaded) {
      final currentState = state as UserLoaded;

      // Не загружаем, если уже достигли конца
      if (currentState.hasReachedMax) return;

      try {
        final users = await getUsers(GetUsersParams(page: event.page));

        emit(
          currentState.copyWith(
            users: [...currentState.users, ...users],
            currentPage: event.page,
            hasReachedMax: users.length < 20,
          ),
        );
      } catch (e) {
        // При ошибке подгрузки оставляем текущее состояние
      }
    }
  }
}
