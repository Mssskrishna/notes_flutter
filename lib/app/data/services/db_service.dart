import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/note_model.dart';

class DBService {
  // this store the db reference
  static Database? _db;

  static Future<void> initDB() async {
    if (_db != null) return;
    _db = await openDatabase(
      //set path to the database safe for all the platforms.
      join(await getDatabasesPath(), 'notes.db'),
      version: 1,
      onCreate: (db, version) async {
        // run the create statement on the database
        await db.execute('''CREATE TABLE notes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          content TEXT NOT NULL,
          createdAt TEXT NOT NULL,
          updatedAt TEXT NOT NULL
        )''');
      },
    );
  }

//future is used to update the ui asynchrously
  static Future<List<Note>> getNotes() async {

    final List<Map<String, dynamic>> maps =
        await _db!.query('notes', orderBy: 'updatedAt DESC');
    return List.generate(maps.length, (i) => Note.fromMap(maps[i]));
  }

  static Future<int> insertNote(Note note) async {
    // /! is used for db is present everytime
    return await _db!.insert('notes', note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(Note note) async {
    return await _db!
        .update('notes', note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

  static Future<int> deleteNote(int id) async {
    return await _db!.delete('notes', where: 'id = ?', whereArgs: [id]);
  }
}
