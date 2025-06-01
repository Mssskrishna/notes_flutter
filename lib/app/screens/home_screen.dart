import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import '../services/theme_service.dart';

class HomeScreen extends StatelessWidget {
  final NoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () => ThemeService().switchTheme(),
          ),
          PopupMenuButton<String>(
            onSelected: (value) => controller.sortBy.value = value,
            itemBuilder: (context) => [
              PopupMenuItem(value: 'title', child: Text('Sort by Title')),
              PopupMenuItem(value: 'updatedAt', child: Text('Sort by Date')),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: InputDecoration(
                hintText: 'Search notes...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.filteredNotes.length,
              itemBuilder: (context, index) {
                final note = controller.filteredNotes[index];
                return Dismissible(
                  key: Key(note.id.toString()),
                  background: Container(color: Colors.red),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (_) async {
                    final confirm = await showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Delete Note'),
                        content: Text('Are you sure?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
                          TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Delete')),
                        ],
                      ),
                    );
                    return confirm;
                  },
                  onDismissed: (_) {
                    controller.deleteNote(note);
                    Get.snackbar(
                      'Note Deleted',
                      'Undo? Click here.',
                      snackPosition: SnackPosition.BOTTOM,
                      mainButton: TextButton(
                        onPressed: () => controller.restoreNote(),
                        child: Text('UNDO'),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.updatedAt.toLocal().toString()),
                    onTap: () => Get.toNamed('/note', arguments: note),
                  ),
                );
              },
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.toNamed('/note'),
      ),
    );
  }
}
