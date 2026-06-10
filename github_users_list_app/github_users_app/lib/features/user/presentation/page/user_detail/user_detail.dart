import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../domain/user.dart';

/// Детальный экран пользователя
/// Отображает расширенную информацию о выбранном пользователе GitHub
class UserDetailPage extends StatelessWidget {
  final User user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.login),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),

            // Аватар с Hero анимацией
            Hero(
              tag: 'avatar_${user.id}',
              child: CircleAvatar(
                radius: 80,
                backgroundImage: CachedNetworkImageProvider(user.avatarUrl),
                backgroundColor: Colors.grey[200],
              ),
            ),

            const SizedBox(height: 20),

            // Логин
            Text(
              user.login,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // Ссылка на профиль
            if (user.htmlUrl != null)
              Text(
                user.htmlUrl!,
                style: const TextStyle(color: Colors.blue, fontSize: 16),
                textAlign: TextAlign.center,
              ),

            const SizedBox(height: 32),

            // Информационные карточки
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    if (user.bio != null && user.bio!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          user.bio!,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),

                    _buildInfoRow(
                      Icons.location_on,
                      user.location ?? 'Не указано',
                    ),
                    _buildInfoRow(
                      Icons.people,
                      '${user.followers ?? 0} подписчиков',
                    ),
                    _buildInfoRow(
                      Icons.person_add,
                      '${user.following ?? 0} подписок',
                    ),
                    _buildInfoRow(
                      Icons.code,
                      '${user.publicRepos ?? 0} репозиториев',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple, size: 28),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
