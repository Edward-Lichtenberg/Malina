import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:malina/src/feature/screens/cart_screen/widgets/cart_item_tile.dart';
import 'package:malina/src/providers/auth_provider.dart';
import 'package:malina/src/providers/cart_provider.dart';
import 'package:malina/src/routes/routes.dart';
import 'package:provider/provider.dart';

@RoutePage()
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    // Загрузка корзины при входе
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = context.read<AuthProvider>();
      if (auth.currentUser != null) {
        context.read<CartProvider>().loadItems(auth.currentUser!.username);
      }
    });
  }

  Future<void> _handleLogout(BuildContext context) async {
    final save = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Выход'),
        content: const Text('Сохранить данные корзины?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Удалить'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );

    if (save != null) {
      final auth = context.read<AuthProvider>();
      await auth.logout(save: save);
      context.router.replace(const WelcomeRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.read<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleLogout(context),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.router.push(const AddItemRoute()),
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(child: Text('Корзина пуста'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final item = cart.items[index];
              return CartItemTile(
                item: item,
                index: index,
                username: auth.currentUser!.username,
              );
            },
          );
        },
      ),
    );
  }
}
