import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:malina/src/core/theme/app_styles.dart';
import 'package:malina/src/routes/routes.dart';

@RoutePage(name: 'MainNavigatorRoute')
class PersistentNavBarNavigatorPage extends StatelessWidget {
  const PersistentNavBarNavigatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoTabsScaffold(
        routes: const [HomeRoute(), CartRoute(), AddItemRoute()],
        bottomNavigationBuilder: (context, tabsRouter) => Container(
          // Адаптивный контейнер для BottomNavigationBar
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          color: AppStyles.disabled,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppStyles
                .primary, // Используем selectedItemColor для консистентности
            unselectedItemColor: AppStyles.primary,
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) => tabsRouter.setActiveIndex(index),
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.view_module_outlined),
                label: "Лента",
                activeIcon: buildGreenIcon((Icons.view_module), context),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.shopping_cart_outlined),
                label: "Корзина",
                activeIcon: buildGreenIcon((Icons.shopping_cart), context),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.publish_outlined),
                label: "Добавить товар",
                activeIcon: buildGreenIcon((Icons.publish), context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Переименован и принимает context
  Widget buildGreenIcon(final IconData icon, BuildContext context) {
    // final scaleFactor = AdaptiveScale.of(context)?.scaleFactor ?? 1.0;
    const baseSize = 24.0; // Базовый размер иконки
    const height = baseSize;
    const width = height * 1.2; // Фиксированное соотношение 1.2 вместо h * 2

    return ClipRRect(
      borderRadius: BorderRadius.circular(350),
      child: Container(
        height: height,
        width: width,
        color: AppStyles.disabled,
        child: ColorFiltered(
          colorFilter: const ColorFilter.mode(
            AppStyles.primary,
            BlendMode.srcIn,
          ),
          child: Icon(icon, color: AppStyles.background, size: baseSize * 0.8),
        ),
      ),
    );
  }
}
