import 'package:equatable/equatable.dart';

/// Доменная сущность пользователя (Entity)
/// Это чистая бизнес-модель, независимая от источников данных
class User extends Equatable {
  final int id;
  final String login;
  final String avatarUrl;
  final String? name;
  final String? bio;
  final String? location;
  final int? followers;
  final int? following;
  final int? publicRepos;
  final String? htmlUrl;

  const User({
    required this.id,
    required this.login,
    required this.avatarUrl,
    this.name,
    this.bio,
    this.location,
    this.followers,
    this.following,
    this.publicRepos,
    this.htmlUrl,
  });

  @override
  List<Object?> get props => [
    id,
    login,
    avatarUrl,
    name,
    bio,
    location,
    followers,
    following,
    publicRepos,
    htmlUrl,
  ];
}
