// user.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String username,
    required String password,
    Map<String, dynamic>? settings,
    @Default(3) int attempts,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

// user.dart
// class User {
//   final String username;
//   final String password;
//   final Map<String, dynamic> settings;

//   User({
//     required this.username,
//     required this.password,
//     this.settings = const {},
//   });

//   User copyWith({Map<String, dynamic>? settings}) {
//     return User(
//       username: username,
//       password: password,
//       settings: settings ?? this.settings,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     'username': username,
//     'password': password,
//     'settings': settings,
//   };

//   static User fromJson(Map<String, dynamic> json) {
//     return User(
//       username: json['username'],
//       password: json['password'],
//       settings: json['settings'] ?? {},
//     );
//   }
// }
