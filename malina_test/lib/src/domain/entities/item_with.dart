// item.dart
// Логика: Модель товара
// Оптимизация: Ручная реализация
// Использование: В корзине
// Возможные расширения: Дополнительные поля (image)

class Item {
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String category;

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'price': price,
    'quantity': quantity,
    'category': category,
  };

  static Item fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      description: json['description'],
      price: json['price'],
      quantity: json['quantity'],
      category: json['category'],
    );
  }
}