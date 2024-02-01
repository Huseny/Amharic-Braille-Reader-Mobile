import 'package:amharic_braille/application/models/translation_model.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'translations.db');
    return await openDatabase(path, version: 1, onCreate: _createTable);
  }

  Future<void> _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE translations(
        id TEXT PRIMARY KEY,
        image BLOB,
        braille TEXT,
        translation TEXT,
        createdAt TEXT
      )
    ''');
  }

  Future<int> insertTranslation(TranslationModel translation) async {
    Database db = await database;
    return await db.insert('translations', translation.toMap());
  }

  Future<List<TranslationModel>> getAllTranslations() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('translations');
    return List.generate(maps.length, (index) {
      return TranslationModel.fromJson(maps[index]);
    });
  }
}
