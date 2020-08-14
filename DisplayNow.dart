import 'package:flutter/material.dart';

class DisplayNow extends StatefulWidget {
  @override
  _DisplayNowState createState() => _DisplayNowState();
}

class _DisplayNowState extends State<DisplayNow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Display Now"),
        ),
        body: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Display Now',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          letterSpacing: 1.0),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Display Now app allows businesses to manage, control and operate their display devices for meetings, advertisements, entertainment etc remotely from a single admin app',
                      style: TextStyle(
                          color: Colors.black, fontSize: 15, wordSpacing: 4.0),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image.network(
                        'https://successive.tech/wp-content/uploads/2020/01/Add-Display.png'),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Features of Display Now',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Businesses can create a Display List, feed in the details of the content they want to show, tag content to any number of screens and that’s it. The system will start presenting the content in real-time',
                      style: TextStyle(
                          color: Colors.black, fontSize: 15, wordSpacing: 4.0),
                    )
                  ],
                ),
              )
            ])));
  }
}
