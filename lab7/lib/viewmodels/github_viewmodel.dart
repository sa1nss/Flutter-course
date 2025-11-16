// lib/view_models/github_view_model.dart
import 'package:flutter/foundation.dart';
import '../models/github_user.dart';
import '../repositories/github_repository.dart';

enum GithubState { initial, loading, loaded, error }

class GithubViewModel extends ChangeNotifier {
  final GithubRepository repository;

  GithubViewModel({required this.repository});

  GithubUser? _user;
  String? _errorMessage;
  GithubState _state = GithubState.initial;

  GithubUser? get user => _user;
  String? get errorMessage => _errorMessage;
  GithubState get state => _state;

  Future<void> fetchUser(String username) async {
    _state = GithubState.loading;
    _errorMessage = null;
    _user = null;
    notifyListeners();

    try {
      final u = await repository.getUser(username);
      _user = u;
      _state = GithubState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = GithubState.error;
    }

    notifyListeners();
  }

  void clear() {
    _user = null;
    _errorMessage = null;
    _state = GithubState.initial;
    notifyListeners();
  }
}
