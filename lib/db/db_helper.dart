import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'hostel_manager.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE members(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            balance REAL
          )
        ''');
        
        await db.execute('''
          CREATE TABLE meals(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            member_id INTEGER,
            date TEXT,
            breakfast INTEGER DEFAULT 0,
            lunch INTEGER DEFAULT 0,
            dinner INTEGER DEFAULT 0,
            FOREIGN KEY (member_id) REFERENCES members(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE market(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            item TEXT,
            amount REAL,
            date TEXT
          )
        ''');
      },
    );
  }
}
