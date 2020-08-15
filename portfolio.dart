import 'package:FacebookLoginApp/BIMNetworks.dart';
import 'package:FacebookLoginApp/DigitalInsights.dart';
import 'package:FacebookLoginApp/DisplayNow.dart';
import 'package:FacebookLoginApp/Kredin.dart';
import 'package:FacebookLoginApp/MeetingHub.dart';
import 'package:FacebookLoginApp/NETFacilities.dart';
import 'package:flutter/material.dart';

class PortfolioView extends StatelessWidget {
  Widget _buildAboutDialog(
      BuildContext context, String titletext, String img, String text) {
    return new AlertDialog(
      title: Text(titletext),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.network(
              img,
              fit: BoxFit.cover,
              height: 100,
            ),
          ),
          SizedBox(height: 18),
          _buildAboutText(text),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Ok'),
        ),
      ],
    );
  }

  Widget _buildAboutText(String text) {
    return new RichText(
        text: new TextSpan(
      text: text,
      style: const TextStyle(color: Colors.black87),
    ));
  }

  Card makeDashboardItem(String title, String imageUrl, Function onTab) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      shadowColor: Colors.black,
      elevation: 15.0,
      color: Colors.blueGrey[50],
      margin: new EdgeInsets.all(8.0),
      //    child: Container(
      //      alignment: Alignment.center,
      // //decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
      // decoration: BoxDecoration(color: Colors.transparent,),

      child: new InkWell(
        onTap: onTab,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            //  SizedBox(height: 50.0),

            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Center(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 100,
                ),
                //   child: Icon(
                // icon,
                // size: 40.0,
                // color: Colors.black,
                // )
              ),
            ),
            //                     SizedBox(height: 20.0),
            new Center(
              child: new Text(title,
                  style: new TextStyle(fontSize: 18.0, color: Colors.black)),
            )
          ],
        ),
      ),

      //   )
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text("Portfolio"),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [Colors.white, Colors.white, Colors.white])),
          //  width: double.infinity,
          child: Center(
            child: GridView.count(
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisCount: 2,
              //  padding: EdgeInsets.all(3.0),
              children: <Widget>[
                Center(
                    child: makeDashboardItem("Meeting Hub",
                        'https://successive.tech/wp-content/uploads/2020/01/4_4.png',
                        () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MeetingHub()),
                  );

                  // showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) => _buildAboutDialog(
                  //         context,
                  //         "Meeting Hub",
                  //         "https://successive.tech/wp-content/uploads/2020/01/4_4.png",
                  //         "Meeting Hub is a SaaS-based platform that automates meeting room booking processes and related billings from a single comprehensive dashboard allowing you to manage all aspects of your bookings, from refunds or cancellations to rescheduling and inventory handling."));
                })),
                Center(
                    child: makeDashboardItem("NETFacilities",
                        'https://successive.tech/wp-content/uploads/2020/02/AMT-min-1.png',
                        () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NetFacilities()),
                  );
                })),
                Center(
                    child: makeDashboardItem("BIM Networks",
                        'https://successive.tech/wp-content/uploads/2020/01/BIM_Networks.png',
                        () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BimNetwork()),
                  );
                })),
                Center(
                    child: makeDashboardItem("Display Now",
                        'https://successive.tech/wp-content/uploads/2020/01/Display_now.png',
                        () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DisplayNow()),
                  );
                })),
                Center(
                    child: makeDashboardItem("Digital Insights",
                        'https://successive.tech/wp-content/uploads/2020/01/Insigt_Planner.png',
                        () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DigitalInsights()),
                  );
                })),

                Center(
                    child: makeDashboardItem("Kredin",
                        'https://successive.tech/wp-content/uploads/2020/01/kredin.png',
                        () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Kredin()),
                  );
                })),

                // Center(
                //    child:  makeDashboardItem("10 Federal – Kiosk", 'https://successive.tech/wp-content/uploads/2020/02/10_Federal_kiosk.png',()async{
                //    showDialog(
                //   context: context,
                //   builder: (BuildContext context) => _buildAboutDialog(context,"10 Federal – Kiosk","https://successive.tech/wp-content/uploads/2020/02/10_Federal_kiosk.png","10 Fed Kiosk is a windows-based application that runs on kiosk machines to assist customers renting out units in a storage facility by providing an end to end self service digital system."));
                // })),

                // Center(
                //    child:  makeDashboardItem("NETFacilities", 'https://successive.tech/wp-content/uploads/2020/02/AMT-min-1.png',()async{
                //    showDialog(
                //   context: context,
                //   builder: (BuildContext context) => _buildAboutDialog(context,"NETFacilities","https://successive.tech/wp-content/uploads/2020/02/AMT-min-1.png","NET Facilities is a cloud based industry agnostic CMMS software which companies of all shapes and size use to manage their facilities, assets, service routines, maintenance routines etc"));
                // })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
