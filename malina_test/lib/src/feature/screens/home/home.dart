// Константы для стилей
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:malina/src/core/theme/app_styles.dart';
import 'package:malina/src/providers/search.dart';
import 'package:malina/src/routes/routes.dart';
import 'package:provider/provider.dart';

part '../home/widgets/discount_card.dart';
part '../home/widgets/category_card.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Обработка поиска
  void _handleSearch() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      context.read<SearchProvider>().searchItems(query); // Вызов провайдера
      // Навигация на экран результатов (можно добавить)
    }
  }

  // Обработка сканирования QR
  void _handleQRScan() {
    context.router.push(const AddItemRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.background,
      appBar: AppBar(
        title: const Text(
          'Малина',
          style: TextStyle(color: AppStyles.background),
        ),
        backgroundColor: AppStyles.primary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppStyles.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Поисковая строка
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Искать в Малине',
                prefixIcon: const Icon(Icons.search, color: AppStyles.disabled),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _searchController.clear(),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppStyles.spacingSmall),
                ),
                filled: true,
                fillColor: AppStyles.disabled,
              ),
              onSubmitted: (_) => _handleSearch(),
            ),
            const SizedBox(height: 16),
            // Рекомендация с QR
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppStyles.padding),
              decoration: BoxDecoration(
                color: AppStyles.primary,
                borderRadius: BorderRadius.circular(AppStyles.cardRadius),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.qr_code_scanner,
                    color: AppStyles.background,
                    size: 40,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Сканируй QR-код и забирай промо в заведении',
                    style: TextStyle(
                      color: AppStyles.background,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _handleQRScan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppStyles.background,
                    ),
                    child: const Text(
                      'Сканировать',
                      style: TextStyle(color: AppStyles.accent),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Категории
            const Text('Категории', style: AppStyles.heading2),
            const SizedBox(height: 16),
            // Карточка "Еда"
            _buildCategoryCard(
              title: 'Еда',
              subtitle: 'На кафе и рестораны',
              // imagePath: 'assets/images/food.jpg', // Placeholder
              color: AppStyles.yellow,
            ),
            const SizedBox(height: 16),
            // Карточка "Бьюти"
            _buildCategoryCard(
              title: 'Бьюти',
              subtitle: 'Салоны красоты и товары',
              // imagePath: 'assets/images/beauty.jpg', // Placeholder
              color: AppStyles.surface,
            ),
            const SizedBox(height: 24),
            // Раздел "Скидки в Малине"
            const Text('Скидки в Малине', style: AppStyles.heading2),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDiscountCard(
                    title: 'Банкрот',
                    color: AppStyles.primaryLight,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDiscountCard(
                    title: 'Market',
                    color: AppStyles.primaryLight,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDiscountCard(
                    title: 'Льготы',
                    color: AppStyles.primaryLight,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppStyles.primaryLight,
                    borderRadius: BorderRadius.circular(AppStyles.cardRadius),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.coffee,
                        size: 40,
                        color: AppStyles.primaryLight,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Еда',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
