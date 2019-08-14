import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'note.dart';

class DBHelper {
  static final DBHelper _instance = new DBHelper.internal();
  DBHelper.internal();

  factory DBHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await setDB();
    return _db;
  }

  setDB() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "SaveDB");
    var dB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return dB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE note(id INTEGER PRIMARY KEY, title TEXT, note TEXT,createDate TEXT,updateDate TEXT,sortDate TEXT)");
    print("DB Created");
  }

  Future<int> SaveNote(Note note) async {
    var dbClient = await db;
    int res = await dbClient.insert("note", note.toMap());
    print("data Insert");
    return res;
  }

  Future<List<Note>> getNote() async {
    var dbClient = await db;
    List<Map> list =
        await dbClient.rawQuery("SELECT * FROM note ORDER BY sortDate");
    List<Note> notedata = new List();
    for (int i = 0; i < list.length; i++) {
      var note = new Note(list[i]['title'], list[i]['note'],
          list[i]['createDate'], list[i]['updateDate'], list[i]['sortDate']);
      note.setNoteId(list[i]['id']);
      notedata.add(note);
    }
    return notedata;
  }

  Future<bool> UpdateNote(Note note) async {
    var dbClient = await db;
    int res = await dbClient
        .update("note", note.toMap(), where: "id=?", whereArgs: <int>[note.id]);
    return res > 0 ? true:false;
  }
  Future<int> deleteNote(Note note) async{
    var dbClient = await db;
    int res = await dbClient.rawDelete("DELETE FROM note WHERE id = ?", [note.id]);
    return res;
  }
}
