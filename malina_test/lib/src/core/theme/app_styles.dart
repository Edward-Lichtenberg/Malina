// Логика: Глобальные стили приложения (цвета, отступы, радиусы, шрифты)
// Оптимизация: Один источник истины (DRY)
// Использование: Все экраны, виджеты, провайдеры
// Возможные расширения: Темная тема, кастомизация

import 'package:flutter/material.dart';

class AppStyles {
  // ЦВЕТА
  static const Color primary = Color(0xFFF72055); // Розовый (основной)
  static const Color primaryLight = Color(0xFFFF69B4); // Светлый розовый
  static const Color accent = Color(0xFFFF1744); // Красный акцент
  static const Color background = Color(0xFFF5F5F5); // Фон
  static const Color surface = Color(0xffFFDEDD); // Карточки, поля
  static const Color error = Colors.red; // Ошибки
  static const Color success = Colors.green; // Успех
  static const Color yellow = Color(0xFFFFDF94); // Успех
  static const Color textPrimary = Color(0xFF212121); // Основной текст
  static const Color textSecondary = Color(0xFF757575); // Второстепенный
  static const Color disabled = Color(0xFFBDBDBD); // Неактивные

  // ОТСТУПЫ
  static const double padding = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingSmall = 12.0;

  // ПРОМЕЖУТКИ
  static const double spacing = 16.0;
  static const double spacingSmall = 8.0;
  static const double spacingLarge = 24.0;

  // РАЗМЕРЫ
  static const double maxWidth = 420.0; // Ограничение ширины
  static const double buttonHeight = 52.0;
  static const double iconSize = 24.0;
  static const double cardRadius = 16.0;
  static const double borderRadius = 12.0;

  // ШРИФТЫ
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  static const TextStyle body = TextStyle(fontSize: 16, color: textPrimary);
  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    color: textSecondary,
  );
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // ТЕМЫ
  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: background,
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      filled: true,
      fillColor: surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    // cardTheme: CardTheme(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(cardRadius),
    //   ),
    //   elevation: 2,
    // ),
    textTheme: const TextTheme(
      headlineLarge: heading1,
      headlineMedium: heading2,
      bodyLarge: body,
      bodyMedium: bodySmall,
    ),
  );
}
