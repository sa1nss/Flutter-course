import 'package:flutter/foundation.dart';
import '../models/profile.dart';
import '../repositories/profile_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileRepository _repository = ProfileRepository();

  List<Profile> _profiles = [];
  late Profile _selectedProfile;

  List<Profile> get profiles => _profiles;

  Profile get profile => _selectedProfile;

  /// Завантаження при запуску
  Future<void> loadProfiles() async {
    _profiles = await _repository.loadProfiles();
    notifyListeners();
  }

  void selectProfile(Profile profile) {
    _selectedProfile = profile;
    notifyListeners();
  }

  Future<void> addProfile(Profile profile) async {
    await _repository.addProfile(profile);
    _profiles = _repository.getAllProfiles();
    notifyListeners();
  }

  Future<void> duplicateProfile(Profile profile) async {
    await _repository.duplicateProfile(profile);
    _profiles = _repository.getAllProfiles();
    notifyListeners();
  }
}
