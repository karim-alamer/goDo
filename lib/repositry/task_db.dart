import 'package:go_do/app/data/models/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  static const _databaseName = 'todo.db';
  static const _taskstable = 'tasks_table';
  static const _databaseversion = 1;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute("""CREATE TABLE tasks_table(
         id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING ,note STRING,date STRING,starttime STRING,endtime STRING,repeat STRING,reminder INTEGER,colorindex INTEGER,isCompleted INTEGER,taskColor INTEGER
        )""");
  }

  Future<int> insertTask(TaskModel task) async {
    Database? db = await database;

    return db.insert(_taskstable, task.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllTasks() async {
    Database? db = await database;
    return await db.query(_taskstable);
  }

  Future<int> delete(int id) async {
    Database? db = await database;
    return await db.delete(_taskstable, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(TaskModel task, int? id) async {
    Database? db = await database;
    final result = await db.rawUpdate(
        '''UPDATE $_taskstable SET title = ?, note = ?, date = ?, starttime= ?, endtime = ?, repeat = ?, reminder = ?, colorindex = ?, isCompleted = ?, taskColor=? WHERE id = ?''',
        [
          task.title,
          task.note,
          task.date.toString(),
          task.starttime.toString(),
          task.endtime.toString(),
          task.repeat,
          task.reminder,
          task.colorindex,
          task.isCompleted,
          task.taskColor,
          id
        ]);
    return result;
  }

  Future<int> updateTaskComplete(bool? value, int? id) async {
    Database? db = await database;
    final result = await db.rawUpdate(
        '''UPDATE $_taskstable SET  isCompleted = ? WHERE id = ?''',
        [value, id]);
    return result;
  }
}
