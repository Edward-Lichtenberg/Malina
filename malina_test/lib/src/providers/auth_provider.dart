// ТЗ: Пункт 1 + 2 + 3
// Реализовано:
//   • Первый вход → сохраняется
//   • Повторные → проверка пароля
//   • 3 попытки → удаление ВСЕХ данных
//   • Счётчик не сбрасывается при перезапуске
//   • Каждый пользователь: cart, settings, attempts

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:malina/src/providers/cart_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:malina/src/domain/entities/user.dart';
import 'package:malina/src/data/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final CartProvider _cartProvider;

  User? _currentUser;
  int _attempts = 3;
  bool _isAuthenticated = false;

  AuthProvider({required CartProvider cartProvider})
    : _cartProvider = cartProvider;

  User? get currentUser => _currentUser;
  int get attempts => _attempts;
  bool get isAuthenticated => _isAuthenticated;

  // Инициализация при старте
  void initializeUser(User user) {
    _currentUser = user;
    _isAuthenticated = true;
    _attempts = user.attempts ?? 3;
    notifyListeners();
  }

  // ВХОД
  Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('users') ?? '{}';
    final users = Map<String, dynamic>.from(jsonDecode(usersJson));
    final userData = users[username];

    // 1. ПЕРВЫЙ ВХОД — РЕГИСТРАЦИЯ
    if (userData == null) {
      final newUser = User(username: username, password: password, attempts: 3);
      await _authService.saveUser(newUser);
      await _saveLogin(username);
      _currentUser = newUser;
      _isAuthenticated = true;
      _attempts = 3;
      notifyListeners();
      return true;
    }

    // 2. ПОВТОРНЫЙ ВХОД — ПРОВЕРКА ПАРОЛЯ
    final isValid = await _authService.checkCredentials(username, password);
    if (isValid) {
      final savedUser = User.fromJson(userData);
      final updatedUser = savedUser.copyWith(attempts: 3);
      await _authService.saveUser(updatedUser);
      await _saveLogin(username);
      _currentUser = updatedUser;
      _isAuthenticated = true;
      _attempts = 3;
      notifyListeners();
      return true;
    }

    // 3. НЕВЕРНЫЙ ПАРОЛЬ — УМЕНЬШАЕМ ПОПЫТКИ
    final savedUser = User.fromJson(userData);
    final newAttempts = (savedUser.attempts ?? 3) - 1;
    final updatedUser = savedUser.copyWith(attempts: newAttempts);

    // КРИТИЧЕСКИ: сохраняем в SharedPreferences
    await _authService.saveUser(updatedUser);

    _attempts = newAttempts;

    if (_attempts <= 0) {
      await _logoutAndDelete(username);
    } else {
      notifyListeners();
    }
    return false;
  }

  // ВЫХОД
  Future<void> logout({bool save = false}) async {
    if (_currentUser != null) {
      if (save) {
        await _cartProvider.saveCartToPrefs(_currentUser!.username);
      } else {
        await _cartProvider.clearCart(_currentUser!.username);
        await _authService.deleteUser(_currentUser!.username);
      }
    }
    await _clearLogin();
    _currentUser = null;
    _isAuthenticated = false;
    _attempts = 3;
    notifyListeners();
  }

  // ВНУТРЕННИЕ МЕТОДЫ
  Future<void> _saveLogin(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_username', username);
  }

  Future<void> _clearLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('current_username');
  }

  Future<void> _logoutAndDelete(String username) async {
    await _cartProvider.clearCart(username);
    await _authService.deleteUser(username);
    await _clearLogin();
    _currentUser = null;
    _isAuthenticated = false;
    _attempts = 3;
    notifyListeners();
  }
}
