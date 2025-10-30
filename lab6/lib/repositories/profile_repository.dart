import '../models/profile.dart';

class ProfileRepository {
  final List<Profile> _profiles = [
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

  List<Profile> getAllProfiles() => _profiles;

  Profile getProfileByIndex(int index) => _profiles[index];

  void addProfile(Profile profile) {
    _profiles.add(profile);
  }

  void duplicateProfile(Profile profile) {
    final newProfile = Profile(
      name: '${profile.name} (Копія)',
      title: profile.title,
      email: profile.email,
      bio: profile.bio,
    );
    _profiles.add(newProfile);
  }
}
