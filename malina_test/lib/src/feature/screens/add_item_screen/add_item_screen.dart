// add_item_screen.dart
// Логика: Экран добавления товара
// Оптимизация: LayoutBuilder
// Использование: Ручная валидация QR
// Возможные расширения: Автозаполнение QR

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:malina/src/core/theme/app_styles.dart';
import 'package:malina/src/domain/entities/item.dart';
import 'package:malina/src/feature/screens/add_item_screen/data/utils/validate_qr_code.dart';
import 'package:malina/src/routes/routes.dart';
import 'package:malina/src/widgets/custom_text_field.dart';
import 'package:malina/src/providers/auth_provider.dart';
import 'package:malina/src/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

@RoutePage()
class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isScanning = false;
  String _category = 'general';

  Future<void> _saveItem() async {
    if (_formKey.currentState!.validate()) {
      final priceText = _priceController.text.trim();
      final price = double.tryParse(priceText);

      // ПРОВЕРКА: price не null и не пустой
      if (price == null || price <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Введите корректную цену')),
        );
        return;
      }
      final auth = context.read<AuthProvider>();
      final cart = context.read<CartProvider>();

      final item = Item(
        name: _nameController.text,
        description: _descController.text,
        price: price,
        quantity: 1,
        category: _category,
      );

      cart.addItem(item, auth.currentUser!.username);

      // УСПЕШНО — возвращаемся
      context.router.push(const CartRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > constraints.maxHeight;
        return Scaffold(
          appBar: AppBar(title: const Text('Добавить товар')),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppStyles.padding),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() => _isScanning = true),
                      child: const Text('Сканировать QR'),
                    ),
                    if (_isScanning)
                      SizedBox(
                        height: isLandscape ? constraints.maxHeight * 0.4 : 300,
                        child: MobileScanner(
                          onDetect: (capture) {
                            final code = capture.barcodes.first.rawValue ?? '';
                            setState(() => _isScanning = false);
                            final category = validateQRCode(code);
                            if (category != null) {
                              _category = category;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'QR валиден: категория "$_category"',
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Невалидный QR')),
                              );
                            }
                          },
                        ),
                      ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _nameController,
                      label: 'Название',
                      validator: (v) => v!.isEmpty ? 'Введите название' : null,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _descController,
                      label: 'Описание',
                      maxLines: 3,
                      validator: (v) => null, // Опционально
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: _priceController,
                      label: 'Цена',
                      keyboardType: TextInputType.number,
                      // В CustomTextField для цены
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Введите цену';
                        final price = double.tryParse(v);
                        if (price == null || price <= 0)
                          return 'Цена должна быть > 0';
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _saveItem,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStyles.primaryLight,
                      ),
                      child: const Text('Сохранить'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
