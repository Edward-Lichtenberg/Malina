import '../../user/domain/user.dart';

/// Модель данных для работы с JSON (Data Layer)
/// Используется для парсинга ответа от GitHub API
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.login,
    required super.avatarUrl,
    super.name,
    super.bio,
    super.location,
    super.followers,
    super.following,
    super.publicRepos,
    super.htmlUrl,
  });

  /// Фабричный конструктор из JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      login: json['login'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      name: json['name'],
      bio: json['bio'],
      location: json['location'],
      followers: json['followers'],
      following: json['following'],
      publicRepos: json['public_repos'],
      htmlUrl: json['html_url'],
    );
  }

  /// Преобразование Model → Entity
  User toEntity() {
    return User(
      id: id,
      login: login,
      avatarUrl: avatarUrl,
      name: name,
      bio: bio,
      location: location,
      followers: followers,
      following: following,
      publicRepos: publicRepos,
      htmlUrl: htmlUrl,
    );
  }
}
