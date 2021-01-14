import 'package:ChatBot/home.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: HomeApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome",
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 65),
                child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) => MyApp()));
                    },
                    child: Text('ChatBot'))),
          ],
        ),
      ),
    );
  }

  //for better one I have use the bubble package check out the pubspec.yaml

}
