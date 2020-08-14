import 'package:flutter/material.dart';

class MeetingHub extends StatefulWidget {
  @override
  _MeetingHubState createState() => _MeetingHubState();
}

class _MeetingHubState extends State<MeetingHub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Meeting Hub"),
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
                      'Meeting Hub',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          letterSpacing: 1.0),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Meeting Hub is a SaaS-based platform that automates meeting room booking processes and related billings from a single comprehensive dashboard allowing you to manage all aspects of your bookings, from refunds or cancellations to rescheduling and inventory handling.',
                      style: TextStyle(
                          color: Colors.black, fontSize: 15, wordSpacing: 4.0),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image.network(
                        'https://successive.tech/wp-content/uploads/2020/01/banner.png'),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Features of Meeting Hub',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'The white-label solution is branded as the operator and provides the ability to convert their existing web visitors into paying customers, therefore increasing traffic to the centers.',
                      style: TextStyle(
                          color: Colors.black, fontSize: 15, wordSpacing: 4.0),
                    )
                  ],
                ),
              )
            ]))));
  }
}
