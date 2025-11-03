import 'package:flutter/foundation.dart';

class SearchProvider with ChangeNotifier {
  String _searchQuery = '';
  List<String> _searchResults =
      []; // Пример результатов (замени на реальные данные)

  String get searchQuery => _searchQuery;
  List<String> get searchResults => _searchResults;

  // Обновление запроса поиска
  void searchItems(String query) {
    _searchQuery = query;
    // Симуляция поиска (замени на реальный API или данные)
    _searchResults = query.isNotEmpty
        ? ['Результат 1 для "$query"', 'Результат 2 для "$query"']
        : [];
    notifyListeners();
  }

  // Очистка поиска
  void clearSearch() {
    _searchQuery = '';
    _searchResults = [];
    notifyListeners();
  }
}
