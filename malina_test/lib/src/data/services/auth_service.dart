// auth_service.dart
// Логика: Сервис для валидации пользователей
// Оптимизация: Асинхронная работа с shared_preferences
// Использование: Интеграция с AuthProvider
// Возможные расширения: Шифрование паролей

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:malina/src/domain/entities/user.dart';

class AuthService {
  Future<bool> checkCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('users') ?? '{}';
    final users = Map<String, dynamic>.from(jsonDecode(usersJson));

    final userData = users[username];
    if (userData == null) return false;

    final savedUser = User.fromJson(userData);
    return savedUser.password == password;
  }

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('users') ?? '{}';
    final users = Map<String, dynamic>.from(jsonDecode(usersJson));

    users[user.username] = user.toJson();
    await prefs.setString('users', jsonEncode(users));
  }

  Future<User?> loadUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('users') ?? '{}';
    final users = Map<String, dynamic>.from(jsonDecode(usersJson));

    final userData = users[username];
    return userData != null ? User.fromJson(userData) : null;
  }

  Future<void> deleteUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('users') ?? '{}';
    final users = Map<String, dynamic>.from(jsonDecode(usersJson));

    users.remove(username);
    await prefs.setString('users', jsonEncode(users));
  }
}
