// Виджет карточки скидки
part of '../home.dart';

Widget _buildDiscountCard({required String title, required Color color}) {
  return Container(
    padding: const EdgeInsets.all(AppStyles.paddingSmall),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(AppStyles.cardRadius),
    ),
    child: Column(
      children: [
        const Icon(Icons.category, size: 40, color: AppStyles.disabled),
        const SizedBox(height: 4),
        Text(title, style: AppStyles.heading1),
      ],
    ),
  );
}
