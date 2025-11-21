// lib/models/github_user.dart
import 'dart:convert';

class GithubUser {
  final String login;
  final String name;
  final String avatarUrl;
  final String htmlUrl;
  final String bio;
  final int publicRepos;
  final int followers;
  final int following;
  final DateTime createdAt;
  final String location;

  GithubUser({
    required this.login,
    required this.name,
    required this.avatarUrl,
    required this.htmlUrl,
    required this.bio,
    required this.publicRepos,
    required this.followers,
    required this.following,
    required this.createdAt,
    required this.location,
  });

  factory GithubUser.fromJson(Map<String, dynamic> json) {
    return GithubUser(
      login: json['login'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
      bio: json['bio'] ?? '',
      publicRepos: json['public_repos'] ?? 0,
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime(1970),
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'name': name,
      'avatar_url': avatarUrl,
      'html_url': htmlUrl,
      'bio': bio,
      'public_repos': publicRepos,
      'followers': followers,
      'following': following,
      'created_at': createdAt.toIso8601String(),
      'location': location,
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}
