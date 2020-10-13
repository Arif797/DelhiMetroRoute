import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void response(query) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/chatbotservices.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    print('HelloooooooooooooooooooooooooooooAIIIIIIII');
    AIResponse aiResponse = await dialogflow.detectIntent(query);

    print('Hellooooooooooooooooooooooooooooo');

    setState(() {
      messsages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString()
      });
    });
  }

  final messageInsert = TextEditingController();
  List<Map> messsages = List();

  @override
  Widget build(BuildContext context) {
    //messsages.insert(0, {"data": 3, "message": ''});

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Successive Chat Bot",
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                "${DateFormat("jm").format(DateTime.now())}",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: messsages.length,
                    itemBuilder: (context, index) => chat(
                        messsages[index]["message"].toString(),
                        messsages[index]["data"]))),
            Divider(
              height: 5.0,
              color: Colors.deepOrange,
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: TextField(
                    controller: messageInsert,
                    decoration: InputDecoration.collapsed(
                        hintText: "Send your message",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                  )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.send,
                          size: 30.0,
                          color: Colors.deepOrange,
                        ),
                        onPressed: () {
                          if (messageInsert.text.isEmpty) {
                            print("empty message");
                          } else {
                            setState(() {
                              messsages.insert(0,
                                  {"data": 1, "message": messageInsert.text});
                            });
                            response(messageInsert.text);
                            messageInsert.clear();
                          }
                        }),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

  //for better one I have use the bubble package check out the pubspec.yaml

  Widget chat(String message, int data) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Bubble(
          radius: Radius.circular(15.0),
          color:
              data == 0 || data == 3 ? Colors.deepOrange : Colors.orangeAccent,
          elevation: 10.0,
          alignment: data == 0 ? Alignment.topLeft : Alignment.topRight,
          nip: data == 0 ? BubbleNip.leftBottom : BubbleNip.rightTop,
          child: Padding(
            padding: EdgeInsets.all(2.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage(data == 0 || data == 3
                      ? "assets/bot.png"
                      : "assets/user.png"),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Flexible(
                    child: Text(
                  message,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
                data == 3
                    ? Container(
                        height: 200,
                        width: 200,
                        child: Column(
                          children: [
                            Text(
                              "Hello, welcome to Successive Technologies. What may I assist you with today?",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15.0),
                            ),
                            FlatButton(
                                onPressed: () {
                                  setState(() {
                                    messsages.insert(0, {
                                      "data": 1,
                                      "message": 'Job Related Query'
                                    });
                                  });
                                  response('Job Related Query');
                                  messageInsert.clear();
                                },
                                child: Text(
                                  'Job Related Query',
                                  style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                )),
                            FlatButton(
                                onPressed: () {
                                  setState(() {
                                    messsages.insert(0, {
                                      "data": 1,
                                      "message": 'Explore Tech Solutions'
                                    });
                                  });
                                  response('Explore Tech Solutions');
                                  messageInsert.clear();
                                },
                                child: Text(
                                  'Explore Tech Solutions',
                                  style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                )),
                            FlatButton(
                                onPressed: () {
                                  setState(() {
                                    messsages.insert(0, {
                                      "data": 1,
                                      "message": 'Other Inquiries'
                                    });
                                  });
                                  response('Other Inquiries');
                                  messageInsert.clear();
                                },
                                child: Text(
                                  'Other Inquiries',
                                  style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                ))
                          ],
                        ))
                    : Container()
              ],
            ),
          )),
    );
  }
}

void abcd() async {
  print('dssssssssssssssssssssssssssss');
  AuthGoogle authGoogle =
      await AuthGoogle(fileJson: "assets/chatbotservices.json").build();
  Dialogflow dialogflow =
      Dialogflow(authGoogle: authGoogle, language: Language.english);
  print('HelloooooooooooooooooooooooooooooAIIIIIIII');
  AIResponse aiResponse = await dialogflow.detectIntent("hi");
}
