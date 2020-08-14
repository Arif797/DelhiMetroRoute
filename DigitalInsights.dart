import 'package:flutter/material.dart';

class DigitalInsights extends StatefulWidget {
  @override
  _DigitalInsightsState createState() => _DigitalInsightsState();
}

class _DigitalInsightsState extends State<DigitalInsights> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Digital Insights"),
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
                      'Digital Insights',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          letterSpacing: 1.0),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Digital Insights will serve as tools and resource recommendation engine based on the media brief provided by the user. It will highlight the best uses cases for each research tool, easing the user journey by adding more relevance.',
                      style: TextStyle(
                          color: Colors.black, fontSize: 15, wordSpacing: 4.0),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image.network(
                        'https://successive.tech/wp-content/uploads/2020/01/Home2@2x.png'),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Features of Digital Insights',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'All tools needed for user research under one hood. Permission based access management for tools with different types of request access. Access to paid tools allowed by admins on the basis of waitlist of requests.',
                      style: TextStyle(
                          color: Colors.black, fontSize: 15, wordSpacing: 4.0),
                    )
                  ],
                ),
              )
            ]))));
  }
}
