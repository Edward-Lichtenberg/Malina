// src/feature/screens/welcome_screen.dart
// ТЗ: Пункт 1 — Система авторизации
// Реализовано:
//   • Первый вход — сохраняется локально
//   • Повторные — проверка пароля
//   • 3 попытки → блокировка + удаление данных
//   • Счётчик не сбрасывается при перезапуске
//   • Уведомления: "Осталось попыток", "Аккаунт заблокирован"
//   • auto_route + MainNavigatorRoute

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:malina/src/core/theme/app_styles.dart';
import 'package:malina/src/feature/screens/welcome_screen/data/utils/error_message.dart';
import 'package:malina/src/providers/auth_provider.dart';
import 'package:malina/src/routes/routes.dart';
import 'package:malina/src/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  String? _usernameError;
  String? _passwordError;

  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(_validate);
    _passwordController.addListener(_validate);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validate() {
    setState(() {
      _usernameError = _usernameController.text.isEmpty
          ? 'Введите email'
          : !_emailRegex.hasMatch(_usernameController.text)
          ? 'Неверный email'
          : null;
      _passwordError = _passwordController.text.length < 8
          ? 'Минимум 8 символов'
          : null;
    });
  }

  Future<void> _handleLogin() async {
    _validate();
    if (_formKey.currentState!.validate() &&
        _usernameError == null &&
        _passwordError == null) {
      final auth = context.read<AuthProvider>();
      final success = await auth.login(
        _usernameController.text,
        _passwordController.text,
      );

      if (success) {
        context.router.replace(const MainNavigatorRoute());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppStyles.padding),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Заголовок
              const Text(
                'Малина',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppStyles.primary,
                ),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                controller: _usernameController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator: (_) => _usernameError,
              ),
              const SizedBox(height: AppStyles.spacing),
              CustomTextField(
                controller: _passwordController,
                label: 'Пароль',
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
                validator: (_) => _passwordError,
              ),
              const SizedBox(height: AppStyles.spacing),

              // ← РЕАЛТАЙМ СООБЩЕНИЯ
              Consumer<AuthProvider>(
                builder: (context, auth, _) {
                  if (auth.attempts == 0) {
                    return const ErrorMessage(
                      'Аккаунт удалён. Зарегистрируйтесь заново.',
                      color: Colors.red,
                    );
                  } else if (auth.attempts < 3 && auth.attempts > 0) {
                    return ErrorMessage(
                      'Осталось попыток: ${auth.attempts}',
                      color: Colors.orange,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: AppStyles.buttonHeight,
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Войти',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
