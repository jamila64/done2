import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('perfect_task_db.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    //  المستخدمين
    await db.execute('''CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, image TEXT)''');
    // التصنيفات
    await db.execute('''CREATE TABLE categories (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, color TEXT)''');
    //  المهام
    await db.execute('''CREATE TABLE tasks (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      user_id INTEGER, 
      cat_id INTEGER, 
      title TEXT, 
      isDone INTEGER,
      FOREIGN KEY (user_id) REFERENCES users (id),
      FOREIGN KEY (cat_id) REFERENCES categories (id)
    )''');
    // إضافة تصنيف افتراضي
    await db.insert('categories', {'name': 'General', 'color': '0xFF3F51B5'});

  }
}