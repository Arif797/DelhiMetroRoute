import 'package:flutter/material.dart';

class Kredin extends StatefulWidget {
  @override
  _KredinState createState() => _KredinState();
}

class _KredinState extends State<Kredin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Kredin"),
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
                      'Kredin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          letterSpacing: 1.0),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Kredin is a Debt Collection System for businesses in Norway that facilitates efficient management of cash-flow and debt collection. Kredin automates payment reminders, payment notices to debtors for multiple debt accounts making accounting much easier.',
                      style: TextStyle(
                          color: Colors.black, fontSize: 15, wordSpacing: 4.0),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image.network(
                        'https://successive.tech/wp-content/uploads/2020/01/Screen_1@2x.png'),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Features of Kredin',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Kredin allows its clients to collect the debt for multiple companies using a single user account. It also enables the clients to create users for managing the debt collection process for each company individually.',
                      style: TextStyle(
                          color: Colors.black, fontSize: 15, wordSpacing: 4.0),
                    )
                  ],
                ),
              )
            ]))));
  }
}
