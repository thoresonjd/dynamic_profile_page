import 'package:dynamic_profile_page/db/model/profile.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProfileDatabase {
  // Calls constructor
  static final ProfileDatabase instance = ProfileDatabase._init();

  // sqflite database object
  static Database? _database;

  // Constructor
  ProfileDatabase._init();

  // Allows connection to database
  Future<Database> get database async {
    // Return database if already exists
    if (database != null) {
      return _database!;
    }
    // Create database
    _database = await _initDB('profile.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath(); // Path to local storage on device
    final path = join(dbPath, filePath); // Names the file
    return await openDatabase(path, version: 1, onCreate: _createDB); // Necessary to define db schema
  }

  // Create database, create table
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $profileTable (
        ${ProfileFields.id} ${ProfileTypes.id},
        ${ProfileFields.username} ${ProfileTypes.username},
        ${ProfileFields.description} ${ProfileTypes.description}
      )
    ''');
  }

  // Create profile instance
  Future<Profile> create(Profile profile) async {
    final db = await instance.database; // Get database
    final id = await db.insert(profileTable, profile.toJson()); // Insert into database
    return profile.copy(id: id);
  }

  // Read single profile
  Future<Profile> readProfile(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      profileTable,
      columns: ProfileFields.values,
      where: '${ProfileFields.id} = ?',
      whereArgs: [id]
    );

    if (maps.isNotEmpty) {
      return Profile.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  // Read all profiles
  Future<List<Profile>> readAllProfiles() async {
    final db = await instance.database;
    final result = await db.query(profileTable);
    return result.map((json) => Profile.fromJson(json)).toList();
  }

  // Update a profile
  Future<int> updateProfile(Profile profile) async {
    final db = await instance.database;
    return db.update(
      profileTable,
      profile.toJson(),
      where: '${ProfileFields.id} = ?',
      whereArgs: [profile.id]
    );
  }

  // Close database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}