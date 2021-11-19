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

  Future _createDB(Database db, int version) async {
    
  }

  // Close database
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}