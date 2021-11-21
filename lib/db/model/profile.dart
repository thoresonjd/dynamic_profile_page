const String profileTable = 'profiles';

class ProfileTypes {
  static const String id = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String username = 'VARCHAR(20) NOT NULL';
  static const String description = 'VARCHAR(250) NOT NULL';
  static const String time = 'TEXT NOT NULL';
}

class ProfileFields {
  static final List<String> values = [
    /// Add all fields
    id, username, description, time
  ];

  static const String id = '_id';
  static const String username = 'username';
  static const String description = 'description';
  static const String time = 'time';
}

class Profile {
  final int? id;
  final String username;
  final String description;
  final DateTime createdTime;

  const Profile({
    this.id,
    required this.username,
    required this.description,
    required this.createdTime,
  });

  Profile copy({
    int? id,
    String? username,
    String? description,
    DateTime? createdTime,
  }) =>
      Profile(
        id: id ?? this.id,
        username: username ?? this.username,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Profile fromJson(Map<String, Object?> json) => Profile(
    id: json[ProfileFields.id] as int?,
    username: json[ProfileFields.username] as String,
    description: json[ProfileFields.description] as String,
    createdTime: DateTime.parse(json[ProfileFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    ProfileFields.id: id,
    ProfileFields.username: username,
    ProfileFields.description: description,
    ProfileFields.time: createdTime.toIso8601String(),
  };
}
