import 'package:flutter/foundation.dart';
import 'package:prototyping/dto/anime.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _db;

  factory DBHelper() => _instance;

  DBHelper._internal();

  Future<Database> get db async {
    _db ??= await initDatabase();
    return _db!; // Use the already initialized _db
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'db_anime.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE anime (id INTEGER PRIMARY KEY, title TEXT, status TEXT, progress INTEGER, score REAL, startDate TEXT, endDate TEXT)');
  }

  Future<Anime> add(Anime anime) async {
    var dbClient = await db;
    anime.id = await dbClient.insert('anime', anime.toMap());
    return anime;
  }

  Future<List<Anime>> getAnime() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps =
        await dbClient.query('anime', orderBy: 'id DESC');
    List<Anime> anime = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        anime.add(Anime.fromMap(maps[i]));
      }
    }
    return anime;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'anime',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Anime anime) async {
    var dbClient = await db;
    return await dbClient.update(
      'anime',
      anime.toMap(),
      where: 'id = ?',
      whereArgs: [anime.id],
    );
  }

  Future<void> close() async {
    try {
      // Access database client
      var dbClient = await db;
      _db = null;
      await dbClient.close();
    } catch (error) {
      // Handle potential errors during closure
      debugPrint('Error closing database: $error');
    }
  }
}
