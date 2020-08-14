import 'package:flutter/material.dart';

class NetFacilities extends StatefulWidget {
  @override
  _NetFacilitiesState createState() => _NetFacilitiesState();
}

class _NetFacilitiesState extends State<NetFacilities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("NET Facilities"),
        ),
        body: Container(
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      'NET Facilities',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          letterSpacing: 1.0),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'NET Facilities is a cloud based industry agnostic CMMS software which companies of all shapes and size use to manage their facilities, assets, service routines, maintenance routines etc.',
                      style: TextStyle(
                          color: Colors.black, fontSize: 15, wordSpacing: 4.0),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image.network(
                        'https://successive.tech/wp-content/uploads/2020/02/AMT-min-1.png'),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Features of NET Facilities',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Successive had to create an entire platform right from scratch and automate certain processes. We built  the ERP Mobile App from scratch while reusing the existing code of Xamarin Forms by converting it into Xamarin Native. The resulting app improved workflow across the organization and led to informed decision making at the time of prospecting, lead generation, and project management.',
                      style: TextStyle(
                          color: Colors.black, fontSize: 15, wordSpacing: 4.0),
                    )
                  ],
                ),
              )
            ]))));
  }
}
