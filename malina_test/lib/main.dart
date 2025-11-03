// main.dart
// Логика: Точка входа приложения, настройка Provider
// Оптимизация: MultiProvider для минимизации rebuilds
// Использование: MaterialApp с ручной навигацией
// Возможные расширения: Темы (ThemeData)

import 'package:flutter/material.dart';
import 'package:malina/src/data/services/auth_service.dart';

import 'package:malina/src/providers/auth_provider.dart';
import 'package:malina/src/providers/cart_provider.dart';
import 'package:malina/src/providers/search.dart';
import 'package:malina/src/providers/settings_provider.dart';
import 'package:malina/src/routes/routes.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final cartProvider = CartProvider();
  final authProvider = AuthProvider(cartProvider: cartProvider);
  final authService = AuthService();

  final savedUsername = prefs.getString('current_username');

  if (savedUsername != null) {
    final user = await authService.loadUser(savedUsername);
    if (user != null) {
      if ((user.attempts ?? 3) > 0) {
        authProvider.initializeUser(user);
        await cartProvider.loadItems(savedUsername);
      } else {
        // Пользователь заблокирован — полная очистка
        await cartProvider.clearCart(savedUsername);
        await authService.deleteUser(savedUsername);
        await prefs.remove('current_username');
      }
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider.value(value: cartProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Малина',
      theme: ThemeData(
        primaryColor: const Color(0xFFFF69B4),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        useMaterial3: true,
      ),
      routerConfig: AppRouter().config(),
    );
  }
}
