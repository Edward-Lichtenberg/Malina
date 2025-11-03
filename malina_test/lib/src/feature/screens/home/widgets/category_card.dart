// Виджет карточки категории
part of '../home.dart';

Widget _buildCategoryCard({
  required String title,
  required String subtitle,
  // required String imagePath,
  required Color color,
}) {
  return Container(
    height: 150,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(AppStyles.spacingSmall),
    ),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: AppStyles.body),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: AppStyles.textSecondary),
                ),
              ],
            ),
          ),
        ),
        const ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppStyles.buttonHeight),
            bottomRight: Radius.circular(AppStyles.cardRadius),
          ),
          // child: Image.asset(
          //   imagePath,
          //   width: 120,
          //   height: 120,
          //   fit: BoxFit.cover,
          // ),
        ),
      ],
    ),
  );
}
