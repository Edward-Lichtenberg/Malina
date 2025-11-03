// item.dart
// Логика: Модель товара с Freezed
// Оптимизация: Immutable, JSON сериализация
// Использование: fromJson/toJson
// Возможные расширения: Дополнительные поля (image)

import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@freezed
abstract class Item with _$Item {
  const factory Item({
    @Default('') String name,
    @Default('') String description,
    @Default(0.0) double price,
    @Default(0) int quantity,
    @Default('') String category,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
