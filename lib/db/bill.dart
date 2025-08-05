part of 'db.dart';

class DatabaseBill {
  static final DatabaseBill _instance = DatabaseBill._internal();
  factory DatabaseBill() => _instance;
  DatabaseBill._internal();

  static const String _dbName = 'myWallet.db';
  static const String _storeName = 'my_wallet_store';

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
    } catch (e) {
      throw Exception("❗ Gagal membuka database: $e");
    }
  }

  //* ➕ Insert data baru
  static Future<int> insertTagihan(ExpensesModel tagihan) async {
    try {
      final db = await database;
      return await _store.add(db, tagihan.toJson());
    } catch (e) {
      throw Exception("❗ Gagal menambah tagihan: $e");
    }
  }

  //* ✏️ Update/Edit tagihan
  static Future<void> updateTagihan(ExpensesModel tagihan) async {
    try {
      if (tagihan.id == null) {
        throw Exception("❗ Tagihan tidak memiliki ID, tidak bisa update");
      }
      final db = await database;
      await _store.record(tagihan.id!).put(db, tagihan.toJson());
    } catch (e) {
      throw Exception("❗ Gagal mengedit tagihan (ID: ${tagihan.id}): $e");
    }
  }

  //* ❌ Hapus tagihan berdasarkan ID
  static Future<int?> deleteTagihan(int id) async {
    try {
      final db = await database;
      return await _store.record(id).delete(db);
    } catch (e) {
      throw Exception("❗ Gagal menghapus tagihan (ID: $id): $e");
    }
  }

  //* 📄 Ambil semua tagihan dengan pagination
  static Future<List<ExpensesModel>> getAllTagihan(
      {int offset = 0, int limit = 5}) async {
    try {
      final db = await database;
      final finder = Finder(
          offset: offset, limit: limit, sortOrders: [SortOrder(Field.key)]);
      final records = await _store.find(db, finder: finder);

      return records.map((snapshot) {
        return ExpensesModel.fromJson(snapshot.value, id: snapshot.key);
      }).toList();
    } catch (e) {
      throw Exception("❗ Gagal mengambil semua tagihan: $e");
    }
  }

  //* 🔍 Ambil tagihan berdasarkan tipe
  static Future<List<ExpensesModel>> getByType({TagihanType? type}) async {
    try {
      final db = await database;
      final finder = Finder(filter: Filter.equals('type', type?.name));
      final records = await _store.find(db, finder: finder);

      return records.map((snapshot) {
        return ExpensesModel.fromJson(snapshot.value, id: snapshot.key);
      }).toList();
    } catch (e) {
      throw Exception("❗ Gagal mengambil tagihan berdasarkan tipe: $e");
    }
  }

  //* ❌ Hapus database
  static Future<int> deleteAllTagihan() async {
    try {
      final db = await database;
      return await _store.delete(db);
    } catch (e) {
      throw Exception("❗ Gagal menghapus semua tagihan: $e");
    }
  }
}
