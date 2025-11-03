// Логика: Гард для проверки авторизации (auto_route v10.2.0)
// Оптимизация: Асинхронная проверка
// Использование: В routes.dart
// Возможные расширения: Роли пользователя

// src/core/guards/auth_guard.dart
import 'package:auto_route/auto_route.dart';
import 'package:malina/src/providers/auth_provider.dart';
import 'package:malina/src/routes/routes.dart';
import 'package:provider/provider.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final auth = router.navigatorKey.currentContext?.read<AuthProvider>();

    if (auth != null && auth.isAuthenticated && auth.currentUser != null) {
      // Пользователь авторизован → пропускаем
      resolver.next();
    } else {
      // Не авторизован → на экран входа
      router.pushAndPopUntil(const WelcomeRoute(), predicate: (_) => false);
    }
  }
}
