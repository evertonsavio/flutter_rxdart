import 'dart:io';
import 'package:flutter_fetch/src/models/ItemModel.dart';
import 'package:flutter_fetch/src/resources/Repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NewsDbaProvider implements Source, Cache {
  late Database db;

  NewsDbaProvider() {
    init();
  }
  
  void init() async {
     Directory documentsDirectory = await getApplicationDocumentsDirectory();
      final path = "${documentsDirectory.path}/items.db";
      db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database newDb, int version) {
          newDb.execute("""
            CREATE TABLE Items
              (
                id INTEGER PRIMARY KEY,
                type TEXT,
                by TEXT,
                time INTEGER,
                text TEXT,
                parent INTEGER,
                kids BLOB,
                dead INTEGER,
                deleted INTEGER,
                url TEXT,
                score INTEGER,
                title TEXT,
                descendants INTEGER
              )
          """);
        }
      );
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns: null, //["title", "url", "score"]
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return ItemModel.fromDb(maps.first);
    }

    return ItemModel();
  }

  @override
  Future<List<int>> fetchTopIds() {
    // TODO: implement fetchTopIds
    throw UnimplementedError();
  }

  @override
  Future<int> addItem(ItemModel item) {
    return db.insert(
        "Items",
        item.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}

final newsDbaProvider = NewsDbaProvider();
