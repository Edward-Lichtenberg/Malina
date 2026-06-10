import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user_bloc/user_bloc.dart';
import '../../../bloc/user_bloc/user_event.dart';
import '../../../bloc/user_bloc/user_state.dart';
import '../user_detail/user_detail.dart';
import 'widgets/user_list_item.dart';

/// Главный экран списка пользователей GitHub
/// Использует infinite scroll (пагинацию) для загрузки пользователей
/// Главный экран списка пользователей GitHub
class UsersListPage extends StatefulWidget {
  const UsersListPage({super.key});

  @override
  State<UsersListPage> createState() => _UsersListPageState();
}

class _UsersListPageState extends State<UsersListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(const LoadUsers());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<UserBloc>().state;
      if (state is UserLoaded && !state.hasReachedMax) {
        context.read<UserBloc>().add(
          LoadMoreUsers(page: state.currentPage + 1),
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Users'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          // Первичная загрузка
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Ошибка (включая отсутствие интернета)
          if (state is UserError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 64, color: Colors.redAccent),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () =>
                        context.read<UserBloc>().add(const LoadUsers()),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Повторить'),
                  ),
                ],
              ),
            );
          }

          // Успешная загрузка
          if (state is UserLoaded) {
            return RefreshIndicator(
              onRefresh: () async =>
                  context.read<UserBloc>().add(const LoadUsers()),
              child: ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.users.length + (state.hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  // Индикатор загрузки в конце списка (пагинация)
                  if (index == state.users.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final user = state.users[index];
                  return UserListItem(
                    user: user,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailPage(user: user),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          }

          return const Center(child: Text('Нет данных'));
        },
      ),
    );
  }
}
