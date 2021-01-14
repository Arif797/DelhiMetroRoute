import 'package:flutter/material.dart';

class BimNetwork extends StatefulWidget {
  @override
  _BimNetworkState createState() => _BimNetworkState();
}

class _BimNetworkState extends State<BimNetwork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BIM Networks"),
        ),
        body: Container(
            child: SingleChildScrollView(
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
                      'BIM Networks',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          letterSpacing: 1.0),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'BIM is a premier payment and customer engagement platform that powers in-store, mobile, and web commerce payments. It is a merchant branded payment platform. It also drives customer engagement and increases efficiency of payment related processes and schemes while also improving reporting and analytics',
                      style: TextStyle(
                          color: Colors.black, fontSize: 15, wordSpacing: 4.0),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image.network(
                        'https://successive.tech/wp-content/uploads/2020/01/Bim-networks-page-1-%E2%80%93-1.png'),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Features of BIM Networks',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'BIM provides Merchants with a white-labeled ACH Debit payment tender that easily integrates into existing mobile apps and websites. With BIM, your customers can be verified and enrolled in your tender in about 40 seconds.',
                      style: TextStyle(
                          color: Colors.black, fontSize: 15, wordSpacing: 4.0),
                    )
                  ],
                ),
              )
            ]))));
  }
}
