part of 'db.dart';

class DatabaseTypeExpanses {
  static final DatabaseTypeExpanses _instance =
      DatabaseTypeExpanses._internal();
  factory DatabaseTypeExpanses() => _instance;
  DatabaseTypeExpanses._internal();

  static const String _dbName = 'typeExpanses.db';
  static const String _storeName = 'type_expanses_store';

  static final _store = intMapStoreFactory.store(_storeName);
  static Database? _db;

  static Future<Database> get database async {
    try {
      if (_db != null) return _db!;

      _db = await databaseFactoryWeb.openDatabase(_dbName);

      return _db!;
    } on DatabaseException catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<TypeModel>> fetchType() async {
    try {
      final db = await database;
      final records = await _store.find(db);
      return records
          .map((e) => TypeModel.fromJson(e.value, id: e.key))
          .toList();
    } on DatabaseException catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<int> insertType(TypeModel title) async {
    try {
      final db = await database;
      return await _store.add(db, title.toJson());
    } on DatabaseException catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<int?> deleteType(int id) async {
    try {
      final db = await database;
      return await _store.record(id).delete(db);
    } on DatabaseException catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<int> deleteDatabase() async {
    try {
      final db = await database;
      return await _store.delete(db);
    } on DatabaseException catch (e) {
      throw Exception(e.toString());
    }
  }
}
