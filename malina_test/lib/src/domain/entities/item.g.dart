// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Item _$ItemFromJson(Map<String, dynamic> json) => _Item(
  name: json['name'] as String? ?? '',
  description: json['description'] as String? ?? '',
  price: (json['price'] as num?)?.toDouble() ?? 0.0,
  quantity: (json['quantity'] as num?)?.toInt() ?? 0,
  category: json['category'] as String? ?? '',
);

Map<String, dynamic> _$ItemToJson(_Item instance) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'quantity': instance.quantity,
  'category': instance.category,
};
