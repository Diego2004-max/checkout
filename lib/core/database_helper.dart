import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'checkout.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        image TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE credit_cards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cardNumber TEXT NOT NULL,
        expiryDate TEXT NOT NULL,
        cvv TEXT NOT NULL,
        cardHolder TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        total REAL NOT NULL,
        date TEXT NOT NULL,
        cardId INTEGER,
        FOREIGN KEY (cardId) REFERENCES credit_cards (id)
      )
    ''');

    await _seedProducts(db);
  }

  Future<void> _seedProducts(Database db) async {
    await db.insert('products', {
      'name': 'Nike Shoes',
      'price': 120.0,
      'image': ''
    });

    await db.insert('products', {
      'name': 'Smart Watch',
      'price': 250.0,
      'image': ''
    });

    await db.insert('products', {
      'name': 'Headphones',
      'price': 80.0,
      'image': ''
    });
  }
}