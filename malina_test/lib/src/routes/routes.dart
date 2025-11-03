import 'package:auto_route/auto_route.dart';
import 'package:malina/src/feature/screens/add_item_screen/add_item_screen.dart';
import 'package:malina/src/feature/screens/cart_screen/cart_screen.dart';
import 'package:malina/src/feature/screens/home/home.dart';
import 'package:malina/src/feature/screens/profile_screen.dart';
import 'package:malina/src/feature/screens/welcome_screen/welcome_screen.dart';
import 'package:malina/src/navig/navigator.dart';
import 'package:malina/src/widgets/persistent_nav_bar_navigator_page.dart';
part 'routes.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [...Navigator.makeRoutes()];
}
