import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE emp(empId INTEGER PRIMARY KEY AUTOINCREMENT, empName TEXT NOT NULL, empRole TEXT NOT NULL, startDate TEXT NOT NULL, endDate TEXT NULL)",
        );
      },
      version: 1,
    );
  }
}
