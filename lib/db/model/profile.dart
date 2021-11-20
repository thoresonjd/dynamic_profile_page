final String profileTable = 'profile';

class ProfileTypes {
  static final String id = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static final String username = 'VARCHAR(30) NOT NULL';
  static final String description = 'VARCHAR(250) NOT NULL';
}

class ProfileFields {
  // Column fields
  static final List<String> values = [id, username, description];

  static final String id = '_id';
  static final String username = 'username';
  static final String description = 'description';
}

class Profile {
  final int? id;
  final String username;
  // TODO: Add profile picture
  // TODO: Add cover photo
  final String description;

  Profile({
    this.id,
    required this.username,
    required this.description,
  });

  Profile copy({
    int? id,
    String? username,
    String? description
  }) =>
    Profile (
      id: id ?? this.id,
      username: username ?? this.username,
      description: description ?? this.description
    );

  static Profile fromJson(Map<String, Object?> json) => Profile(
    id: json[ProfileFields.id] as int?,
    username: json[ProfileFields.username] as String,
    description: json[ProfileFields.description] as String
  );

  Map<String, Object?> toJson() => {
    ProfileFields.id: id,
    ProfileFields.username: username,
    ProfileFields.description: description,
  };
}