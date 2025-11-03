// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  username: json['username'] as String,
  password: json['password'] as String,
  settings: json['settings'] as Map<String, dynamic>?,
  attempts: (json['attempts'] as num?)?.toInt() ?? 3,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'username': instance.username,
  'password': instance.password,
  'settings': instance.settings,
  'attempts': instance.attempts,
};
