import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../domain/user.dart';

/// Виджет одной карточки пользователя в списке
class UserListItem extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const UserListItem({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Аватар
              Hero(
                tag: 'avatar_${user.id}',
                child: CircleAvatar(
                  radius: 32,
                  backgroundImage: CachedNetworkImageProvider(user.avatarUrl),
                  backgroundColor: Colors.grey[300],
                  onBackgroundImageError: (_, _) =>
                      const Icon(Icons.person, size: 32),
                ),
              ),
              const SizedBox(width: 16),

              // Основная информация
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.login,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (user.name != null && user.name!.isNotEmpty)
                      Text(
                        user.name!,
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      'ID: ${user.id}',
                      style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
