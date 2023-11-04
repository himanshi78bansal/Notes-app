import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatelessWidget {
  NoteScreen(this.doc,{super.key});

  final QueryDocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            doc['note_title']
          ),
          Text(
            doc['note_date']
          ),
          Text(
            doc['note_content']
          ),
        ],
      ),
    );
  }
}