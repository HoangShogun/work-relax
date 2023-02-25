import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DBHandler {
  static const String TABLE_NAME = 'my_table';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_NAME = 'name';
  static const String COLUMN_AGE = 'age';

  static final DBHandler _instance = DBHandler._internal();

  factory DBHandler() => _instance;

  DBHandler._internal();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDatabase();
      return _database;
    }
  }

  Future<Database?> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'test_db.db');
    final exists = await databaseExists(path);
    if (exists) {
      return openDatabase(path);
    } else {
      final database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          db.execute(
              'CREATE TABLE $TABLE_NAME($COLUMN_ID INTEGER PRIMARY KEY, $COLUMN_NAME TEXT, $COLUMN_AGE INTEGER)');
        },
      );
      return database;
    }
  }

  

  // Future<Database> createDatabase() async {
  //   final directory =
  //       await getApplicationDocumentsDirectory(); //trả về đường dẫn đến thư mục của app
  //   final path = join(
  //       directory.path, 'test_db.db'); // tạo đường dẫn đến db có tên test_db.db
  //   final exists =
  //       await databaseExists(path); // kiểm tra xem db có tồn tại hay ko
  //   if (exists) {
  //     return openDatabase(path);
  //   } else {
  //     return openDatabase(path, version: 1, onCreate: onCreate);
  //   }
  // }

  // Future<void> onCreate(Database db, int version) async {
  //   //tạo bảng nếu không tồn tại
  //   await db.execute(
  //       'CREATE TABLE $TABLE_NAME($COLUMN_ID INTEGER PRIMARY KEY, $COLUMN_NAME TEXT, $COLUMN_AGE INTEGER)');
  // }
}
