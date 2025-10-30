// lib/services/github_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class GithubService {
  final http.Client httpClient;

  GithubService({http.Client? client}) : httpClient = client ?? http.Client();

  /// Fetch raw user JSON from GitHub API.
  /// Throws an http.ClientException or returns decoded json map.
  Future<Map<String, dynamic>> fetchUser(String username) async {
    final uri = Uri.parse('https://api.github.com/users/$username');
    final response = await httpClient.get(uri, headers: {
      'Accept': 'application/vnd.github+json',
      // optionally set user agent
      'User-Agent': 'Flutter-App',
    });

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body) as Map<String, dynamic>;
      return decoded;
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception(
          'Failed to fetch user: ${response.statusCode} ${response.reasonPhrase}');
    }
  }
}
