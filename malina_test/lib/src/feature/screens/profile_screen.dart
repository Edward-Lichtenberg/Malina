// ТЗ: При выходе — удаление данных

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:malina/src/core/theme/app_styles.dart';
import 'package:malina/src/providers/auth_provider.dart';
import 'package:malina/src/routes/routes.dart';
import 'package:provider/provider.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Переход на экран логина
            await context.read<AuthProvider>().logout();
            context.router.replace(const WelcomeRoute());
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppStyles.primary),
          child: const Text(
            'Выйти',
            style: TextStyle(color: AppStyles.background),
          ),
        ),
      ),
    );
  }
}
