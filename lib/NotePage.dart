import 'package:flutter/material.dart';
import 'DBHelper.dart';
import 'note.dart';

class NotePage extends StatefulWidget {
  NotePage(this._note, this._isNew);

  final Note _note;
  final bool _isNew;
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  Future addRecord() async {
    var db = DBHelper();
    String dateNow =
        "${now.day}-${now.month}-${now.year}, ${now.hour}:${now.minute}";
    var note = Note(cTitle.text, cNote.text, dateNow, dateNow, now.toString());
    await db.SaveNote(note);
    print("saved");
  }

  Future UpdateRecord() async {
    var db = new DBHelper();
    String dateNow =
        "${now.day}-${now.month}-${now.year}, ${now.hour}:${now.minute}";
    var note =
        new Note(cTitle.text, cNote.text, CreateDate, dateNow, now.toString());

    note.setNoteId(this.note.id);
    await db.UpdateNote(note);
  }

  void _saveData() {
    if (widget._isNew) {
      addRecord();
    } else {
      UpdateRecord();
    }
    Navigator.of(context).pop();
  }

  void _editData() {
    setState(() {
      _enabledTextField = true;
      btnEdit = false;
      btnSave = true;
      btnDelete = true;
      title = "EDIT NOTE";
    });
  }

  void delete(Note note) {
    var db = new DBHelper();
    db.deleteNote(note);
  }

  void _confirmDelete() {
    AlertDialog alertDialog = AlertDialog(
      content: Text(
        "Are You Sure About That?",
        style: TextStyle(fontSize: 20.0),
      ),
      actions: <Widget>[
        RaisedButton(
          color: Colors.red,
          child: Text("Delete", style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.pop(context);
            delete(note);
            Navigator.pop(context);
          },
        ),
        RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "cancel",
            style: TextStyle(color: Colors.black),
          ),
          color: Colors.yellow,
        )
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget._note != null) {
      note = widget._note;
      cTitle.text = note.title;
      cNote.text = note.note;
      title = "MY NOTE";
      _enabledTextField = false;
      CreateDate = note.CreateDate;
    }
    super.initState();
  }

  String CreateDate;
  bool _enabledTextField = true;
  Note note;
  var now = DateTime.now();
  String title;
  bool btnDelete = true;
  bool btnEdit = true;
  bool btnSave = false;
  final cTitle = TextEditingController();
  final cNote = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (widget._isNew) {
      title = "NEW NOTE";
      btnSave = true;
      btnEdit = false;
      btnDelete = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
        backgroundColor: Colors.amber,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 25,
              ),
              onPressed: () => Navigator.pop(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CreateButton(
                  icon: Icons.save,
                  enable: btnSave,
                  onpress: _saveData,
                ),
                CreateButton(
                  icon: Icons.edit,
                  enable: btnEdit,
                  onpress: _editData,
                ),
                CreateButton(
                  icon: Icons.delete,
                  enable: btnDelete,
                  onpress: _confirmDelete,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                enabled: _enabledTextField,
                controller: cTitle,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 24.0, color: Colors.grey[800]),
                maxLines: null,
                keyboardType: TextInputType.text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                enabled: _enabledTextField,
                controller: cNote,
                decoration: InputDecoration(
                  hintText: "Your Note",
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 24.0, color: Colors.grey[800]),
                maxLines: null,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.newline,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CreateButton extends StatelessWidget {
  final IconData icon;
  final bool enable;
  final onpress;
  CreateButton({this.icon, this.enable, this.onpress});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: enable ? Colors.purple : Colors.grey),
      child: IconButton(
          icon: Icon(icon),
          color: Colors.white,
          onPressed: () {
            if (enable) {
              onpress();
            }
          }),
    );
  }
}
