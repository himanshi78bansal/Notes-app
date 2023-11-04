import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iceii/NoteEditorScreen.dart';
import 'package:iceii/NoteScreen.dart';
import 'app_style.dart';
// import 'package:notes_app/note_editor_screen.dart';
// import 'package:notes_app/note_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(iceii());
}

class iceii extends StatelessWidget {
  const iceii({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyle.mainColor,
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Notes'),
          centerTitle: true,
          backgroundColor: AppStyle.mainColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your recent Notes",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection('notes').snapshots(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                ),}
                return Text("Ther's no Notes", style: GoogleFonts.nunito(color: Colors.white),);
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteScreen(snapshot.data!.docs[index])));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data!.docs[index].data()['note_title'],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                          Text(snapshot.data!.docs[index].data()['note_date'],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          ),
                          Text(snapshot.data!.docs[index].data()['note_content'],
                          style: TextStyle(
                            fontSize: 18,
                            overflow: TextOverflow.ellipsis,
                          ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data!.docs.length,
                );
            }
            return Text('There is no notes');
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoteEditorScreen()));
          },
          child: Icon(Icons.add),
        ),
        
            ],
          ),
        )
        );
  }
}
