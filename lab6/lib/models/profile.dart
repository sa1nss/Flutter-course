class Profile {
  final String name;
  final String title;
  final String email;
  final String bio;

  const Profile({
    required this.name,
    required this.title,
    required this.email,
    required this.bio,
  });

  Profile copyWith({
    String? name,
    String? title,
    String? email,
    String? bio,
  }) {
    return Profile(
      name: name ?? this.name,
      title: title ?? this.title,
      email: email ?? this.email,
      bio: bio ?? this.bio,
    );
  }
}
