import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> db() async {
    final dbPath = await sql.getDatabasesPath();

    return sql.openDatabase(
      path.join(dbPath, dbName),
      onCreate: (db, version) async {
        const queryString =
            'CREATE TABLE $tablePlaces ($columnId TEXT PRIMARY KEY, $columnTitle TEXT, $columnImage TEXT)';

        await db.execute(queryString);
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.db();

    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.db();

    return db.query(table);
  }

  static const dbName = 'places.db';
  static const tablePlaces = 'places';
  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnImage = 'image';
}
