import 'package:flutter/material.dart';
import 'DBHelper.dart';
import 'NotePage.dart';
import 'notelist.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var db = new DBHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.amber,
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => new NotePage(null, true))),
      ),
      appBar: AppBar(
        leading: Image.asset("img/logo.png"),
        title: Text(
          "Simple note",
          style: TextStyle(color: Colors.white, fontSize: 25.0),
        ),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder(
        future: db.getNote(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          var data = snapshot.data;
          return snapshot.hasData
              ? new NoteList(data)
              : Center(
                  child: Text("No data"),
                );
        },
      ),
    );
  }
}
