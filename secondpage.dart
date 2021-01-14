import 'dart:io';
import 'package:FacebookLoginApp/SignInPage.dart';
import 'package:firebase_storage/firebase_storage.dart'; // For File Upload To Firestore
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'package:path/path.dart' as Path;
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestNotificationPermissions();
      _firebaseMessaging.configure();

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");

      _initialized = true;
    }
  }
}

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Successive"),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange[900],
          Colors.orange[800],
          Colors.orange[400]
        ])),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[]),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Kartik Parashar"),
              accountEmail: Text("kartikparashar@gmail.com"),
              decoration: BoxDecoration(color: Colors.orange[900]),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  "K",
                  style: TextStyle(fontSize: 40.0, color: Colors.orange[900]),
                ),
              ),
              onDetailsPressed: () {
                Drawer(
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        title: Text('Log Out'),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  WelcomePage()));
                        },
                      )
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: Text("Home"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => WelcomePage()));
              },
            ),
            ListTile(
              title: Text("Profile"),
            ),
            ListTile(
              title: Text("Log Out"),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  File _image;

  String _uploadedFileURL;

  Future chooseFile() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _image = image;
      });
      //   _image = image;
    });
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('profileimage/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Selected Image'),
            _image != null
                ? Image.asset(
                    _image.path,
                    height: 150,
                  )
                : Container(height: 150),
            _image == null
                ? RaisedButton(
                    child: Text('Choose File'),
                    onPressed: chooseFile,
                    color: Colors.cyan,
                  )
                : Container(),
            _image != null
                ? RaisedButton(
                    child: Text('Upload File'),
                    onPressed: uploadFile,
                    color: Colors.cyan,
                  )
                : Container(),
            _image != null
                ? RaisedButton(
                    child: Text('Clear Selection'),
                    onPressed: null // clearSelection,
                    )
                : Container(),
            Text('Uploaded Image'),
            _uploadedFileURL != null
                ? Image.network(
                    _uploadedFileURL,
                    height: 150,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
