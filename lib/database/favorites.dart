import 'package:firstproject/coinmarketcap.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Favorites{

  late final Future<Database> database;

  Future connect() async {
    var path = join(await getDatabasesPath(), "crypto.db");
    database = openDatabase(
        path,
        onCreate: (database, version) async {
          await database.execute("CREATE TABLE IF NOT EXISTS favorites(name TEXT PRIMARY KEY)");
        },
        version: 2
    );
  }

  Future addToFavorites(Market market) async {
    var db = await database;
    return db.insert("favorites", market.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future removeFromFavorites(Market market) async {
    var db = await database;
    return db.delete("favorites", where: "name = ?", whereArgs: [market.name]);
  }

  Future getFavorites() async {
    var db = await database;
    List<Map<String, dynamic>> data = await db.query("favorites");
    return List.generate(data.length, (index) {
      return Market(data[index]["name"], 0, "");
    });
  }

}