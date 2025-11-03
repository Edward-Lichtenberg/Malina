// Утилита: Сообщение об ошибке/попытках (Single Responsibility)
import 'package:flutter/material.dart';
import 'package:malina/src/core/theme/app_styles.dart';

class ErrorMessage extends StatelessWidget {
  final String? message;
  final Color? color;

  const ErrorMessage(this.message, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        message!,
        style: TextStyle(
          color: color ?? AppStyles.error,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
