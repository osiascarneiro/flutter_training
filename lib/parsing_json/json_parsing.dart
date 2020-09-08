import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class JsonParsingSample extends StatefulWidget {
  @override
  _JsonParsingSampleState createState() => _JsonParsingSampleState();
}

class _JsonParsingSampleState extends State<JsonParsingSample> {

  Future data;

  @override
  void initState() {
    super.initState();
    data = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parsing Json"),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: getData(),
            builder: (conter, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.hasData) {
                return createListView(snapshot.data, context);
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Future getData() async {
    Future data;
    String url = "https://jsonplaceholder.typicode.com/posts";
    Network network = Network(url);

    data = network.fetchData();

    return data;
  }

}

Widget createListView(List data, BuildContext context) {
  return Container(
    child: ListView.builder(
      itemCount: data.length,
        itemBuilder: (context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Divider(height: 0.5),
              ListTile(
                title: Text(data[index]['title']),
                subtitle: Text(data[index]['body'].toString()),
                leading: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black26,
                      radius: 23,
                      child: Text(data[index]['id'].toString()),
                    )
                  ],
                ),
              )
            ],
          );
    }),
  );
}

class Network {

  final String url;

  Network(this.url);

  Future fetchData() async {
    Response response = await get(Uri.encodeFull(url));
    if(response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
    }
  }

}
