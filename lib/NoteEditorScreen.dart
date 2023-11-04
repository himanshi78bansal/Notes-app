import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteEditorScreen extends StatelessWidget {
  NoteEditorScreen({super.key});

  final String date = DateTime.now().toString();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Note Title',
            ),
            controller: titleController,
          ),
          Text(date),
          TextField(
            decoration: InputDecoration(
              hintText: 'Note Content'
            ),
            controller: contentController,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('notes').add({
            'note_title': titleController.text,
            'note_date': date,
            'note_content': contentController.text,
          }
          ).then((value) {
            Navigator.pop(context);
          });
        },
        child: Icon(Icons.save),
      ),
    );
  }
}