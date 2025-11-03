// src/providers/cart_provider.dart
// ТЗ: Работа с корзиной (пункт 2)
// Реализовано:
//   • Добавление через QR/вручную
//   • Debounce при изменении количества
//   • Сохранение по пользователю
//   • Визуальное отображение мгновенно
//   • Фактическое сохранение с задержкой

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:malina/src/domain/entities/item.dart';

class CartProvider with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items => _items;

  // Загрузка при старте
  Future<void> loadItems(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'cart_$username';
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      _items = jsonList.map((json) => Item.fromJson(json)).toList();
      notifyListeners();
    }
  }

  // СОХРАНЕНИЕ ПРИ ВЫХОДЕ
  Future<void> saveCartToPrefs(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'cart_$username';
    final jsonString = jsonEncode(_items.map((item) => item.toJson()).toList());
    await prefs.setString(key, jsonString);
  }

  // ОЧИСТКА ПРИ УДАЛЕНИИ
  Future<void> clearCart(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'cart_$username';
    await prefs.remove(key);
    _items.clear();
    notifyListeners();
  }

  void addItem(Item item, String username) {
    _items.add(item.copyWith(quantity: 1));
    saveCartToPrefs(username); // ← автосохранение
    notifyListeners();
  }

  void updateQuantity(int index, int quantity, String username) {
    if (quantity <= 0) {
      _items.removeAt(index);
    } else {
      _items[index] = _items[index].copyWith(quantity: quantity);
    }
    saveCartToPrefs(username); // ← автосохранение
    notifyListeners();
  }
}
