import 'package:flutter/material.dart';
import 'NotePage.dart';
import 'note.dart';

class NoteList extends StatefulWidget {
  final List<Note> noteData;
  NoteList(this.noteData, {Key key});
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 2
                  : 3),
      itemCount: widget.noteData.length == null ? 0 : widget.noteData.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext) =>
                    new NotePage(widget.noteData[i], false)));
          },
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: Text(
                    widget.noteData[i].title,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        widget.noteData[i].note,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("Created:${widget.noteData[i].CreateDate}"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                  child: Text(" Update: ${widget.noteData[i].updateDate}"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
