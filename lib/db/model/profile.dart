const String profileTable = 'profile';

class ProfileTypes {
  static const String id = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String username = 'VARCHAR(30) NOT NULL';
  static const String description = 'VARCHAR(250) NOT NULL';
}

class ProfileFields {
  // Column fields
  static final List<String> values = [id, username, description];

  static const String id = '_id';
  static const String username = 'username';
  static const String description = 'description';
}

class Profile {
  final int? id;
  final String username;
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