import 'package:first_flutter_app/board_firestore/util/dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  final QuerySnapshot snapshot;
  final int index;

  const CustomCard({Key key, this.snapshot, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var doc = snapshot.docs[index];
    var timeToDate = DateTime.fromMillisecondsSinceEpoch(
        doc.data()['timestamp'].seconds * 1000
    );
    var dateFormatted = DateFormat("EEEE, MMM d, y").format(timeToDate);

    return Column(
      children: [
        Container(
          height: 190,
          child: Card(
            elevation: 9,
            child: Column(
              children: [
                ListTile(
                  title: Text(doc.get('title')),
                  subtitle: Text(doc.get('description')),
                  leading: CircleAvatar(
                    radius: 34,
                    child: Text(doc.get('title')[0]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("By: ${doc.get('name')} "),
                      Text(dateFormatted),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(FontAwesomeIcons.edit, size: 15),
                      onPressed: () async {
                        DialogUtil.showDialogForm(
                          context,
                          cancel: () => Navigator.pop(context),
                          confirm: (name, title, description) {
                            doc.reference.update({
                              "name":name,
                              "description":description,
                              "title":title,
                              "timestamp":DateTime.now()
                            }).then((value) => Navigator.pop(context));
                          },
                          initialName: doc.get("name"),
                          initialDescription: doc.get("description"),
                          initialTitle: doc.get("title")
                        );
                      },
                    ),
                    SizedBox(height: 19,),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.trashAlt, size: 15),
                      onPressed: () async {
                        var collectionReference = FirebaseFirestore.instance.collection("board");
                        await collectionReference.doc(doc.id).delete();
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
