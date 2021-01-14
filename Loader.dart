import 'dart:async';
import 'package:FacebookLoginApp/MeetingHub.dart';
import 'package:FacebookLoginApp/secondpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello Rectangle',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello Rectangle'),
        ),
        body: HelloRectangle(),
      ),
    ),
  );
}

class HelloRectangle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Center(
          child: FutureBuilder(
            future: buildText(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return CircularProgressIndicator(backgroundColor: Colors.red);
              } else {
                return WelcomePage();
              }
            },
          ),
        ),
      ),
    );
  }

  Future buildText() {
    return Future.delayed(
        const Duration(seconds: 5),
        () => Navigator.push(
            null, MaterialPageRoute(builder: (context) => MeetingHub())));
  }
}
