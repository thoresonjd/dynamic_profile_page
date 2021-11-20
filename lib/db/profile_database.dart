import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dynamic_profile_page/db/model/profile.dart';

class ProfileDatabase {
  static final ProfileDatabase instance = ProfileDatabase._init();

  static Database? _database;

  ProfileDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('profiles.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    

    await db.execute('''
CREATE TABLE $profileTable ( 
  ${ProfileFields.id} ${ProfileTypes.id},
  ${ProfileFields.username} ${ProfileTypes.username},
  ${ProfileFields.description} ${ProfileTypes.description},
  ${ProfileFields.time} ${ProfileTypes.time}
  )
''');
  }

  Future<Profile> create(Profile profile) async {
    final db = await instance.database;
    final id = await db.insert(profileTable, profile.toJson());
    return profile.copy(id: id);
  }

  Future<Profile> readProfile(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      profileTable,
      columns: ProfileFields.values,
      where: '${ProfileFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Profile.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Profile>> readAllProfiles() async {
    final db = await instance.database;
    final orderBy = '${ProfileFields.time} ASC';
    final result = await db.query(profileTable, orderBy: orderBy);
    return result.map((json) => Profile.fromJson(json)).toList();
  }

  Future<int> updateProfile(Profile profile) async {
    final db = await instance.database;

    return db.update(
      profileTable,
      profile.toJson(),
      where: '${ProfileFields.id} = ?',
      whereArgs: [profile.id],
    );
  }

  Future<int> deleteProfile(int id) async {
    final db = await instance.database;

    return await db.delete(
      profileTable,
      where: '${ProfileFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
