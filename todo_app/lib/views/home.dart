import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/model/model.dart';
import 'package:todo_app/views/note_view.dart';
class TodoHome extends StatefulWidget {
  TodoHome({Key? key}) : super(key: key);

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList = [];
  int count = 0;
  @override
  Widget build(BuildContext context) {
     Color mainColor = const Color(0XFF0d0958);
    Color secondColor = Color(0XFF212098);
    Color btnColor = Color(0XFFff955b);
    const Color editorColor = Color(0XFF4044CC);
    if (noteList.isEmpty) {
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('Agenda',style:TextStyle(
          color: Color.fromARGB(255, 8, 171, 158),
          fontWeight: FontWeight.bold,
          fontSize: 35.0)),
        centerTitle: true,
      ),
      body: noteList.isNotEmpty
          ? getNoteListView()
          : Center(
              child: Text(
                "MY TASK",
                style: TextStyle(
                  letterSpacing: 2.0,
                  fontSize: 18.0,
                  backgroundColor: Colors.white10,
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 8, 171, 158),
        child: const Icon(Icons.add,color: Colors.black),
        onPressed: () {
          navigateToDetail(Note("", "", 2), "Add Task", "Save", false);
        },
      ),
    );
  }

  ListView getNoteListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, position) {
        return  Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)
          ),
            margin: EdgeInsets.all(10.0),
            color: Colors.grey.shade300,
            elevation: 9.0,
            
            child: ListTile(
              leading: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/vin.png')),
              title: Text(noteList[position].title.toUpperCase(),
                  style: const TextStyle(
                    letterSpacing: 2.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                  )),
              subtitle: Text(
                noteList[position].date,
                style: const TextStyle(color: Colors.black),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: const Icon(Icons.file_open_outlined, color: Colors.black54),
                    onTap: () {
                      navigateToDetail(
                          noteList[position], "Edit Task ", "Update", true);
                    },
                  ),
                  Text('Open')
                ],
              ),
            ),
          );
        
      },
    );
  }

  void navigateToDetail(
      Note note, String title, String buttonText, bool delButton) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(title, note, buttonText, delButton);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initialzeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          count = noteList.length;
        });
      });
    });
  }

 
}

    
  