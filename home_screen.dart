import 'package:flutter/material.dart';
import 'package:wegotbeef/View/sign_up_2.dart';
import 'package:wegotbeef/src/bottom_navigation.dart';

class HomeScreenPage extends StatefulWidget {
  HomeScreenPage();

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0,
        title: Text(
          'Deliver to 141 Jennings Ave',
          style: TextStyle(
              fontSize: 20.0,
              color: Color.fromRGBO(0, 46, 93, 1.0),
              fontWeight: FontWeight.bold),
        ),
        brightness: Brightness.light,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: Color(0xFF3a3737),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NextSignUpPage()),
                );
              })
        ],
      ),
      body: Center(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(children: <Widget>[
              Flexible(
                  child: Card(
                elevation: 10.0,
                shadowColor: Colors.black,
                color: Colors.white,
                child: Container(
                  child: TextFormField(
                    cursorColor: Colors.black,
                    decoration: new InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 5, bottom: 12, top: 2, right: 5),
                        hintText: 'Find what you want'),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.white, spreadRadius: 3),
                    ],
                  ),
                  height: 30,
                ),
              )),
              Image.asset('assets/images/navigate_icon.png')
            ]),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [Text("Cuts"), Text('See all')],
                ),
                Container(
                  height: 200,
                  width: double.maxFinite,
                  child: Card(
                    elevation: 10,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: 160.0,
                          color: Colors.red,
                        ),
                        Container(
                          width: 160.0,
                          color: Colors.blue,
                        ),
                        Container(
                          width: 160.0,
                          color: Colors.green,
                        ),
                        Container(
                          width: 160.0,
                          color: Colors.yellow,
                        ),
                        Container(
                          width: 160.0,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}
