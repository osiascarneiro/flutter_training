import 'package:firebase_core/firebase_core.dart';
import 'package:first_flutter_app/board_firestore/ui/CustomCard.dart';
import 'package:first_flutter_app/board_firestore/util/dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BoardApp extends StatefulWidget {
  @override
  _BoardAppState createState() => _BoardAppState();
}

class _BoardAppState extends State<BoardApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community Board"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DialogUtil.showDialogForm(context, confirm: (name, title, description) {
            FirebaseFirestore.instance.collection("board").add({
              "name":name,
              "description":description,
              "title":title,
              "timestamp":DateTime.now()
            }).then((value) {
              print(value.id);
              Navigator.pop(context);
            }).catchError((error) {
              print(error);
            });
          }, cancel: () {
            Navigator.pop(context);
          });
        },
        child: Icon(FontAwesomeIcons.pen),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if(snapshot.hasData) return snapshot.data;
          else return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<Widget> getData() async {
    await Firebase.initializeApp();
    var firestoreDb = FirebaseFirestore.instance.collection("board").snapshots();
    return StreamBuilder(
      stream: firestoreDb,
      builder: (context, snapshot) {
        if(!snapshot.hasData) return CircularProgressIndicator();
        else return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return CustomCard(snapshot: snapshot.data, index: index);
            }
        );
      },
    );
  }

}
