/// Центральное место для всех констант приложения
class AppConstants {
  // GitHub API
  static const String baseUrl = 'https://api.github.com';
  static const int perPage =
      20; // Количество пользователей на одну страницу (пагинация)

  // Splash Screen
  static const int splashDuration = 4000; // 4 секунды

  // App Info
  static const String appName = 'GitHub Users';
  static const String appVersion = '1.0.0';
}
