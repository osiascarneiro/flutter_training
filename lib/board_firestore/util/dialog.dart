import 'package:flutter/material.dart';

abstract class DialogUtil {

  static showDialogForm(
      BuildContext context,
      {
        Function cancel,
        Function(String name, String title, String description) confirm,
        String initialName = "",
        String initialDescription = "",
        String initialTitle = ""
      }
      ) async {
    TextEditingController nameInputController = TextEditingController(text: initialName);
    TextEditingController titleInputController = TextEditingController(text: initialTitle);
    TextEditingController descriptionInputController = TextEditingController(text: initialDescription);

    await showDialog(
        context: context,
        child: AlertDialog(
          contentPadding: EdgeInsets.all(10),
          content: Column(
            children: [
              Text("Please fill the form"),
              Expanded(
                child: TextField(
                  autofocus: true,
                  autocorrect: true,
                  decoration: InputDecoration(
                      labelText: "Your name*"
                  ),
                  controller: nameInputController,
                ),
              ),
              Expanded(
                child: TextField(
                  autofocus: true,
                  autocorrect: true,
                  decoration: InputDecoration(
                      labelText: "Title*"
                  ),
                  controller: titleInputController,
                ),
              ),
              Expanded(
                child: TextField(
                  autofocus: true,
                  autocorrect: true,
                  decoration: InputDecoration(
                      labelText: "Description*"
                  ),
                  controller: descriptionInputController,
                ),
              )
            ],
          ),
          actions: [
            FlatButton(
              onPressed: () {
                nameInputController.clear();
                titleInputController.clear();
                descriptionInputController.clear();
                cancel();
              },
              child: Text("Cancel"),
            ),
            FlatButton(
              onPressed: () {
                if(titleInputController.text.isNotEmpty &&
                    nameInputController.text.isNotEmpty &&
                    descriptionInputController.text.isNotEmpty) {
                  confirm(nameInputController.text, titleInputController.text, descriptionInputController.text);
                  nameInputController.clear();
                  titleInputController.clear();
                  descriptionInputController.clear();
                }
              },
              child: Text("Save"),
            )
          ],
        )
    );
  }

}