// Виджет: Отдельный элемент корзины (Single Responsibility, Open/Closed для расширений)
import 'package:flutter/material.dart';
import 'package:malina/src/core/theme/app_styles.dart';
import 'package:malina/src/domain/entities/item.dart';
import 'package:malina/src/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartItemTile extends StatelessWidget {
  final Item item;
  final int index;
  final String username;

  const CartItemTile({
    super.key,
    required this.item,
    required this.index,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartProvider>();

    return ListTile(
      leading: const Icon(Icons.shopping_bag, color: AppStyles.primary),
      title: Text(item.name),
      subtitle: Text('${item.price} руб. | ${item.description}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () =>
                cart.updateQuantity(index, item.quantity - 1, username),
          ),
          Text('${item.quantity}'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                cart.updateQuantity(index, item.quantity + 1, username),
          ),
        ],
      ),
    );
  }
}
