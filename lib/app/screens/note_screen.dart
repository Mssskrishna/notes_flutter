import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/note_controller.dart';
import '../data/models/note_model.dart';

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  final NoteController controller = Get.find();
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  Note? editingNote;

  @override
  void initState() {
    super.initState();
    final arg = Get.arguments;
    if (arg is Note) {
      editingNote = arg;
      titleController.text = arg.title;
      contentController.text = arg.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(editingNote == null ? 'Add Note' : 'Edit Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty ? 'Title is required' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Content'),
                maxLines: 6,
                validator: (value) => value == null || value.isEmpty ? 'Content is required' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final note = Note(
                      id: editingNote?.id,
                      title: titleController.text,
                      content: contentController.text,
                      createdAt: editingNote?.createdAt ?? DateTime.now(),
                      updatedAt: DateTime.now(),
                    );
                    if (editingNote == null) {
                      controller.addNote(note);
                    } else {
                      controller.updateNote(note);
                    }
                    Get.back();
                  }
                },
                child: Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
