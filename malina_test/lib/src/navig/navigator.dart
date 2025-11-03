import 'package:auto_route/auto_route.dart';
import 'package:malina/src/routes/routes.dart';
import 'package:malina/src/core/guard/auth_guard.dart';

extension Navigator on Never {
  static List<AutoRoute> makeRoutes() => [
    AutoRoute(page: WelcomeRoute.page, initial: true),
    // AutoRoute(
    //   page: HomeRoute.page,
    //   guards: [AuthGuard()], // ← ГАРД ДЛЯ АВТОРИЗАЦИИ
    // ),

    // AutoRoute(page: CartRoute.page, guards: [AuthGuard()]),
    AutoRoute(
      page: MainNavigatorRoute.page,
      guards: [AuthGuard()],
      children: [
        AutoRoute(path: 'home', page: HomeRoute.page, initial: true),
        // AutoRoute(
        //   path: 'favorites',
        //   page: FavoritesRoute.page,
        // ),
        // AutoRoute(
        //   path: 'search',
        //   page: SearchRoute.page,
        // ),
        AutoRoute(path: 'add', page: AddItemRoute.page),
        AutoRoute(path: 'profile', page: ProfileRoute.page),
        AutoRoute(path: 'cart', page: CartRoute.page),
      ],
    ),
  ];
}
