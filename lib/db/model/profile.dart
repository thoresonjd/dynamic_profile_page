final String profileTable = 'profiles';

class ProfileTypes {
  static final String id = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static final String username = 'VARCHAR(20) NOT NULL';
  static final String description = 'VARCHAR(250) NOT NULL';
  static final String time = 'TEXT NOT NULL';
}

class ProfileFields {
  static final List<String> values = [
    /// Add all fields
    id, username, description, time
  ];

  static final String id = '_id';
  static final String username = 'username';
  static final String description = 'description';
  static final String time = 'time';
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
