import '../models/profile.dart';
import '../services/local_storage_service.dart';

class ProfileRepository {
  final LocalStorageService _storage = LocalStorageService();

  List<Profile> _profiles = [];

  Future<List<Profile>> loadProfiles() async {
    _profiles = await _storage.loadProfiles();

    if (_profiles.isEmpty) {
      _profiles = [
        const Profile(
          name: 'Данііл Коробков',
          title: 'Студент 3 курсу ХПІ',
          email: 'sa1ns.dt@gmail.com',
          bio: 'Люблю спорт та ігри, також вивчати щось нове',
        ),
        const Profile(
          name: 'Данііл Коробков',
          title: 'SysAdmin',
          email: 'korobkov@gmail.com',
          bio: 'Системний адміністратор в IT-компанії',
        ),
        const Profile(
          name: 'Данііл Коробков',
          title: 'Project Manager',
          email: 'korobkov@gmail.com',
          bio: 'Керую командами розробників',
        ),
      ];

      await _storage.saveProfiles(_profiles);
    }

    return _profiles;
  }

  List<Profile> getAllProfiles() => _profiles;

  Future<void> addProfile(Profile profile) async {
    _profiles.add(profile);
    await _storage.saveProfiles(_profiles);
  }

  Future<void> duplicateProfile(Profile profile) async {
    final newProfile = Profile(
      name: '${profile.name} (Копія)',
      title: profile.title,
      email: profile.email,
      bio: profile.bio,
    );
    _profiles.add(newProfile);
    await _storage.saveProfiles(_profiles);
  }
}
