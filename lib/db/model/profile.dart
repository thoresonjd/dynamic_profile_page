final String profileTable = 'profile';

class ProfileTypes {
  static final String id = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static final String username = 'VARCHAR(30) NOT NULL';
  static final String description = 'VARCHAR(250)';
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
  final String description;
}