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
  Future<void> create(Profile profile) async {
    final db = await instance.database; // Get database
    final id = await db.insert(profileTable, profile.toJson());
    return profile.copy(id: id);
  }

  // Close database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}