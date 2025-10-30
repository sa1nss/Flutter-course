// lib/repositories/github_repository.dart
import '../services/github_service.dart';
import '../models/github_user.dart';

class GithubRepository {
  final GithubService service;

  GithubRepository({required this.service});

  Future<GithubUser> getUser(String username) async {
    final json = await service.fetchUser(username);
    return GithubUser.fromJson(json);
  }
}
