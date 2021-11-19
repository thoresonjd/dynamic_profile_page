final String profileTable = 'profile';

class ProfileTypes {
  static final String id = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static final String username = 'VARCHAR(30) NOT NULL';
  static final String description = 'VARCHAR(250) NOT NULL';
}

class ProfileFields {
  static final String id = '_id';
  static final String username = 'username';
  static final String description = 'description';
}

class Profile {
  final int? id;
  final String? username;
  // TODO: Add profile picture
  // TODO: Add cover photo
  final String? description;

  const Profile({
    this.id,
    required this.username,
    required this.description,
  });

  Profile copy({
    int? id,
    String? username,
  // TODO: Add profile picture
  // TODO: Add cover photo
    String? description
  }) =>
    Profile (
      id: id ?? this.id,
      username: username ?? this.username,
      description: description ?? this.description
    );

  Map<String, Object?> toJson() => {
    ProfileFields.id: id,
    ProfileFields.username: username,
    ProfileFields.description: description,
  };
}