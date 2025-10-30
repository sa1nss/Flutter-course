import 'package:flutter/foundation.dart';
import '../models/profile.dart';
import '../repositories/profile_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileRepository _repository = ProfileRepository();

  late Profile _selectedProfile;

  Profile get profile => _selectedProfile;

  List<Profile> get profiles => _repository.getAllProfiles();

  void selectProfile(Profile profile) {
    _selectedProfile = profile;
    notifyListeners();
  }

  void addProfile(Profile profile) {
    _repository.addProfile(profile);
    notifyListeners();
  }

  void duplicateProfile(Profile profile) {
    _repository.duplicateProfile(profile);
    notifyListeners();
  }
}
