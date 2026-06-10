import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';
import '../users_list/users_list_page.dart';

/// Splash-экран с логотипом GitHub
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Переход на главный экран через 4 секунды
    Future.delayed(
      const Duration(milliseconds: AppConstants.splashDuration),
      () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UsersListPage()),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Логотип GitHub (замените на свой asset)
            Image.asset(
              'assets/images/github_logo.png',
              width: 120,
              height: 120,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.code, size: 120, color: Colors.black),
            ),
            const SizedBox(height: 24),
            const Text(
              'GitHub Users',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'by Clean Architecture',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
