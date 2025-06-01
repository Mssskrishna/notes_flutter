import 'package:get/get.dart';
import '../data/models/note_model.dart';
import '../data/services/db_service.dart';

class NoteController extends GetxController {
  RxList<Note> notes = <Note>[].obs;
  RxString searchQuery = ''.obs;
  RxString sortBy = 'updatedAt'.obs;
  Note? recentlyDeleted;

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  void loadNotes() async {
    await DBService.initDB();
    final data = await DBService.getNotes();
    notes.assignAll(data);
  }

  void addNote(Note note) async {
    await DBService.insertNote(note);
    loadNotes();
  }

  void updateNote(Note note) async {
    await DBService.updateNote(note);
    loadNotes();
  }

  void deleteNote(Note note) async {
    recentlyDeleted = note;
    await DBService.deleteNote(note.id!);
    loadNotes();
  }

  void restoreNote() async {
    if (recentlyDeleted != null) {
      await DBService.insertNote(recentlyDeleted!);
      recentlyDeleted = null;
      loadNotes();
    }
  }

  List<Note> get filteredNotes {
    final query = searchQuery.value.toLowerCase();
    final sorted = List<Note>.from(notes);

    if (sortBy.value == 'title') {
      sorted.sort((a, b) => a.title.compareTo(b.title));
    } else {
      sorted.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    }

    return sorted.where((note) =>
      note.title.toLowerCase().contains(query) ||
      note.content.toLowerCase().contains(query)
    ).toList();
  }
}
