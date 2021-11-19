final String profileTable = 'profile';

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