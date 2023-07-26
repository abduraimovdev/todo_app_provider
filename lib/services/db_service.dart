import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

sealed class SqlDatabase {
  static const dbName = 'todo_database.db';
  static late final Future<Database> database;

  static Future<void> init() async {
    String pathDirectory = await getDatabasesPath();
    String path = join(pathDirectory, dbName);

    database = openDatabase(path, onCreate: _onCreate, version: 1);
  }

  static Future<void> _onCreate(Database db, int version) {
    db.execute(
      'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
    );
    return db.execute(
      'CREATE TABLE todos(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
    );
  }

  static Future<void> insert({required Table table, required Map<String, Object?> data, }) async {
    final db = await database;

    await db.insert(
      table.name,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> update({required Table table, required Map<String, Object?> data, required String id}) async {
    final db = await database;

    await db.update(
      table.name,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, dynamic>>> readAll({required Table table}) async {
    final db = await database;

    return await db.query(table.name);

  }

  static Future<void> delete({required Table table, required int id}) async {
    final db = await database;

    await db.delete(
      table.name,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<Map<String, dynamic>> read({required Table table, required String id}) async {
    final db = await database;

    List<Map<String, Object?>> query = await db.query(
      table.name,
      where: 'id = ?',
      whereArgs: [id],
    );
    return query[0];
  }

  static Future<void> deleteAll({required Table table}) async{
    final db = await database;

    await db.execute("DELETE FROM ${table.name}");
  }
}


enum Table {
  users,
  todos,
}