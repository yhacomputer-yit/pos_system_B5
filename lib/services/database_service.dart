import '../models/customer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;
  static const String tablecustomer = 'customer';
  static const String tableproduct = 'product';
  static const String tableorder = 'order';
  static const String dbname = 'pos.db';
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), dbname);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE $tableproduct(
id INTEGER PRIMARY KEY,
name TEXT,
price REAL,
imageUrl TEXT,
stock INTEGER
)
''');
    await db.execute('''
CREATE TABLE $tablecustomer(
id INTEGER PRIMARY KEY AUTOINCREMENT,
name TEXT,
phone TEXT,
email TEXT
)
''');
    await db.execute('''
CREATE TABLE `$tableorder`(
id INTEGER PRIMARY KEY,
customerId INTEGER,
items TEXT,
total REAL,
date TEXT
)
''');
  }

  // All-in-one helper methods
  //to save customer
Future<int> cussave(Customer c) async => await (await database).insert(tablecustomer, c.toMap());
// to get customer all data
Future<List<Customer>> cusgetAll() async => (await (await database).query(tablecustomer))
    .map((m) => Customer.fromMap(m)).toList();
// to get customer with id for each customer that for edit and delete
Future<Customer?> cusgetById(int id) async {
  final maps = await (await database).query(tablecustomer, where: 'id = ?', whereArgs: [id]);
  if (maps.isEmpty) return null;
  return Customer.fromMap(maps.first);
}

Future<int> cusupdate(Customer c) async => await (await database).update(tablecustomer, c.toMap(), 
    where: 'id = ?', whereArgs: [c.id]);

Future<int> cusdelete(int id) async => await (await database).delete(tablecustomer, 
    where: 'id = ?', whereArgs: [id]);



}
