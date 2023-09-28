import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:test_student_app/data/models/student_model.dart';

class DBServices {
  static DBServices? dbServices;
  static Database? dbase;

  DBServices._createObject();

  factory DBServices() {
    dbServices ??= DBServices._createObject();
    return dbServices!;
  }

  Future<Database> initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = p.join(databasePath, 'dbstudent.db');

    var todoDatabase = openDatabase(path, version: 1, onCreate: createDatabase);
    return todoDatabase;
  }

  static const String _tblStudents = 'students';

  void createDatabase(Database db, int version) async {
    await db.execute(''' 
    CREATE TABLE $_tblStudents (
      id INTEGER PRIMARY KEY,
      name TEXT,
      birthDate TEXT,
      age INTEGER,
      gender INTEGER,
      address TEXT
    )
    ''');
  }

  Future<Database> get database async {
    if (dbServices != null) {
      dbase = await initDatabase();
    }
    return dbase!;
  }

  Future<void> insertStudents(StudentModel studentModel) async {
    final db = await database;
    await db.transaction((txn) async {
      txn.insert(_tblStudents, studentModel.toJson());
    });
    // await db.insert(_tblStudents, studentModel.toJson());
  }

  Future<List<Map<String, dynamic>>> getDataStudents() async {
    Database db = await database;
    final List<Map<String, dynamic>> result = await db.query(_tblStudents);
    return result;
  }

  Future<List<Map<String, dynamic>>> selectById(int id) async {
    Database db = await database;
    final List<Map<String, dynamic>> result =
        await db.query(_tblStudents, where: 'id = $id');
    return result;
  }

  Future<int> update(StudentModel student) async {
    Database db = await database;
    int count = await db.update(_tblStudents, student.toJson(),
        where: 'id = ?', whereArgs: [student.id]);
    return count;
  }

  Future<int> delete(int id) async {
    Database db = await database;
    int count = await db.delete(_tblStudents, where: 'id = ?', whereArgs: [id]);
    return count;
  }
}
