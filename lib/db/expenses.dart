part of 'db.dart';

class DatabaseExpenses {
  static final DatabaseExpenses _instance = DatabaseExpenses._internal();
  factory DatabaseExpenses() => _instance;
  DatabaseExpenses._internal();

  static const String _dbName = 'myExpenses.db';
  static const String _storeName = 'my_expenses_store';

  static final _store = intMapStoreFactory.store(_storeName);
  static Database? _db;

  static Future<Database> get database async {
    try {
      if (_db != null) return _db!;

      if (kIsWeb) {
        // ✅ untuk Web
        _db = await databaseFactoryWeb.openDatabase(_dbName);
      } else {
        // ✅ untuk Android/iOS
        final dir = await getApplicationDocumentsDirectory();
        await dir.create(recursive: true);
        final dbPath = join(dir.path, _dbName);
        _db = await databaseFactoryIo.openDatabase(dbPath);
      }
      return _db!;
    } on DatabaseException catch (e) {
      throw Exception("❗ Gagal membuka database: $e");
    }
  }

  //* ➕ Insert data baru
  static Future<int> insertExpenses(ExpensesModel tagihan) async {
    try {
      final db = await database;
      return await _store.add(db, tagihan.toJson());
    } on DatabaseException catch (e) {
      throw Exception("❗ Gagal menambah tagihan: $e");
    }
  }

  //* ✏️ Update/Edit tagihan
  static Future<void> updateExpenses(ExpensesModel tagihan) async {
    try {
      if (tagihan.id == null) {
        throw Exception("❗ Tagihan tidak memiliki ID, tidak bisa update");
      }
      final db = await database;
      await _store.record(tagihan.id!).put(db, tagihan.toJson());
    } on DatabaseException catch (e) {
      throw Exception("❗ Gagal mengedit tagihan (ID: ${tagihan.id}): $e");
    }
  }

  //* ❌ Hapus tagihan berdasarkan ID
  static Future<int?> deleteExpenses(int id) async {
    try {
      final db = await database;
      return await _store.record(id).delete(db);
    } on DatabaseException catch (e) {
      throw Exception("❗ Gagal menghapus tagihan (ID: $id): $e");
    }
  }

  //* 📄 Ambil semua tagihan dengan pagination
  static Future<List<ExpensesModel>> fetchAllExpenses(
      {int offset = 0, int limit = 5}) async {
    try {
      final db = await database;
      final finder = Finder(
          offset: offset, limit: limit, sortOrders: [SortOrder(Field.key)]);
      final records = await _store.find(db, finder: finder);

      return records.map((snapshot) {
        return ExpensesModel.fromJson(snapshot.value, id: snapshot.key);
      }).toList();
    } on DatabaseException catch (e) {
      throw Exception("❗ Gagal mengambil semua tagihan: $e");
    }
  }

  //* 🔍 Ambil tagihan berdasarkan tipe
  static Future<List<ExpensesModel>> fetchExpensesByType(
      {TagihanType? type}) async {
    try {
      final db = await database;
      final finder = Finder(filter: Filter.equals('type', type?.name));
      final records = await _store.find(db, finder: finder);

      return records.map((snapshot) {
        return ExpensesModel.fromJson(snapshot.value, id: snapshot.key);
      }).toList();
    } on DatabaseException catch (e) {
      throw Exception("❗ Gagal mengambil tagihan berdasarkan tipe: $e");
    }
  }

  //* ❌ Hapus database
  static Future<int> deleteDatabase() async {
    try {
      final db = await database;
      return await _store.delete(db);
    } on DatabaseException catch (e) {
      throw Exception("❗ Gagal menghapus semua tagihan: $e");
    }
  }

  static Future<List<ExpensesModel>> fetchSearchExpenses({
    required String keyword,
    TagihanType? type,
    int offset = 0,
    int limit = 10,
  }) async {
    try {
      final db = await database;

      // Buat filter: tipe + keyword
      final filters = <Filter>[];

      if (type != null) {
        filters.add(Filter.equals('type', type.name));
      }

      if (keyword.isNotEmpty) {
        filters.add(Filter.matchesRegExp(
            'name', RegExp(keyword, caseSensitive: false)));
      }

      final finder = Finder(
        filter: filters.isNotEmpty ? Filter.and(filters) : null,
        sortOrders: [SortOrder('createdAt', false)],
        offset: offset,
        limit: limit,
      );

      final records = await _store.find(db, finder: finder);

      return records
          .map((snapshot) =>
              ExpensesModel.fromJson(snapshot.value, id: snapshot.key))
          .toList();
    } on DatabaseException catch (e) {
      throw Exception("❗ Gagal mencari tagihan: $e");
    }
  }
}
