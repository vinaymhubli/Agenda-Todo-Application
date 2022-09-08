import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/model/model.dart';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;
  final String buttonText;
  final bool delButton;

  const NoteDetail(this.appBarTitle, this.note, this.buttonText, this.delButton,
      {Key? key})
      : super(key: key);

  @override
  _NoteDetailState createState() =>
      _NoteDetailState(appBarTitle, note, buttonText, delButton);
}

class _NoteDetailState extends State<NoteDetail> {
  static final _priorities = ['Higher', 'Lower'];
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  Note note;
  String buttonText;
  bool delButton;

  _NoteDetailState(
      this.appBarTitle, this.note, this.buttonText, this.delButton);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;

    titleController.text = note.title;
    descriptionController.text = note.description;

    return WillPopScope(
      onWillPop: () => moveToLastScreen(),
      child: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text(appBarTitle,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.0),),
          backgroundColor: Colors.teal,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              moveToLastScreen();
            },
          ),
        ),
        body: Container(
          height: 400,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 82, 74),
            borderRadius: BorderRadius.circular(10.0),
                      boxShadow: kElevationToShadow[1]),
          
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(

              color: Colors.grey.shade300,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
                 
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      controller: titleController,
                      style: textStyle,
                      onChanged: (value) {
                        updateTitle();
                      },
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: textStyle,
                        icon: const Icon(Icons.title),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      controller: descriptionController,
                      style: textStyle,
                      onChanged: (value) {
                        updateDescription();
                      },
                      decoration: const InputDecoration(
                        labelText: 'Details',
                        icon: Icon(Icons.details),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(8.0)),
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(255, 5, 60, 136)),
                            ),
                            child: Text(
                              buttonText,
                              style: const TextStyle(letterSpacing: 1.0),
                              textScaleFactor: 1.2,
                            ),
                            onPressed: () {
                              setState(() {
                                _save();
                              });
                            },
                          ),
                        ),
                        delButton
                            ? Container(
                                width: 10.0,
                              )
                            : Container(),
                        delButton
                            ? Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(8.0)),
                                    backgroundColor:
                                        MaterialStateProperty.all(Color.fromARGB(255, 225, 37, 24)),
                                  ),
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(letterSpacing: 1.0),
                                    textScaleFactor: 1.2,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _delete();
                                    });
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDescription() {
    note.description = descriptionController.text;
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
          );
        });
  }

 

  String? getPriorityAsString(int value) {
    String? priority;
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
    }
    return priority;
  }

  moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _save() async {
    moveToLastScreen();
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      result = await helper.updateNote(note);
    } else {
      result = await helper.insertNote(note);
    }
    if (result != 0) {
      _showAlertDialog('Status', 'Note saved successfully');
    } else {
      _showAlertDialog('Status', 'Problem saving Note');
    }
  }

  void _delete() async {
    moveToLastScreen();

    if (note.id!.isNaN) {
      _showAlertDialog('Status', 'First add a note');
      return;
    }

    int result = await helper.deleteNote(note.id!);

    if (result != 0) {
      _showAlertDialog('Status', 'Note deleted successfully');
    } else {
      _showAlertDialog('Status', 'Problem deleting Note');
    }
  }
}
