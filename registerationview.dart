import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tryLoginScreen/View/homeview.dart';
import 'package:tryLoginScreen/View/loginview.dart';
import 'package:tryLoginScreen/bloc/registerationBloc/reg_validation.dart';
import 'package:tryLoginScreen/bloc/registerationBloc/user_reg_bloc.dart';
import 'package:tryLoginScreen/bloc/registerationBloc/user_reg_event.dart';
import 'package:tryLoginScreen/bloc/registerationBloc/user_reg_state.dart';
import 'package:tryLoginScreen/repository/auth_repo.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';
import '../locator.dart';

class RegisterationPageParent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserRegBloc(),
      child: RegisterationPage(),
    );
  }
}

class RegisterationPage extends StatefulWidget {
  @override
  _RegisterationPageState createState() => _RegisterationPageState();
}

class _RegisterationPageState extends State<RegisterationPage> {
  SharedPreferences logindata;

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  final _formKey = GlobalKey<FormState>();
  int _groupValue = -1;
  var myFormat = DateFormat('d-MM-yyyy');
  String gender;
  TextEditingController dateCtl = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode _nameFocusNode = FocusNode();

  FocusNode _emailFocusNode = FocusNode();

  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _genderFocusNode = FocusNode();

  FocusNode _registerbtnFocusNode = FocusNode();

  String a = "1";

  void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Future<bool> emailCheck(String email) async {
    final result = await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .getDocuments();
    return result.documents.isEmpty;
  }

  UserRegBloc userRegBloc;

  @override
  Widget build(BuildContext context) {
    userRegBloc = BlocProvider.of<UserRegBloc>(context);

    return Scaffold(
        body: Center(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blue[600],
          Colors.blue[300],
          Colors.blue[300]
        ])),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlocListener<UserRegBloc, UserRegState>(
                  listener: (context, state) {
                    if (state is UserRegSuccessfulState) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPageParent()),
                      );
                    }
                  },
                  child: BlocBuilder<UserRegBloc, UserRegState>(
                      builder: (context, state) {
                    if (state is UserRegInitialState) {
                      return buildInitialUi();
                    } else if (state is UserLoadingState) {
                      return buildLoadingUi();
                    } else if (state is UserRegSuccessfulState) {
                      return Container();
                    } else if (state is UserRegFailureState) {
                      return buildFailureUi(state.message);
                    }
                  }),
                ),
                //  Text("Registeration", style: TextStyle(color: Colors.white, fontSize: 40),),
                //   SizedBox(height: 10,),
                //  Text("Welcome", style: TextStyle(color: Colors.white, fontSize: 18),),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Center(
                    child: Image.asset(
                      'images/logo_successive.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(30, 95, 255, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: StreamBuilder<Object>(
                                    stream: userRegBloc.userName,
                                    builder: (context, snapshot) {
                                      return TextFormField(
                                        focusNode: _nameFocusNode,
                                        autofocus: true,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            labelText: "Name",
                                            // hintStyle:
                                            //     TextStyle(color: Colors.black),
                                            icon: Icon(Icons.perm_identity),
                                            border: InputBorder.none,
                                            errorText: snapshot.error),
                                        onChanged: userRegBloc.changeUserName,
                                        // controller: nameController,
                                        // textInputAction: TextInputAction.done,
                                        // validator: (name) {
                                        //   if (name.length == 0)
                                        //     return 'Enter the name';
                                        //   else
                                        //     return null;
                                        // },
                                        onFieldSubmitted: (_) {
                                          fieldFocusChange(context,
                                              _nameFocusNode, _genderFocusNode);
                                        },
                                      );
                                    }),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: _genderRadio(
                                    _groupValue, _handleRadioValueChanged),
                              ),
                              Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[200]))),
                                  child: TextFormField(
                                    controller: dateCtl,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Date of birth",
                                      hintStyle: TextStyle(color: Colors.black),
                                      icon: Icon(Icons.date_range),
                                    ),
                                    onTap: () async {
                                      DateTime date = DateTime(1900);
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());

                                      date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime(2019, 1, 1),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100));

                                      dateCtl.text = myFormat.format(date);
                                    },
                                  )),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: StreamBuilder<Object>(
                                    stream: userRegBloc.userEmail,
                                    builder: (context, snapshot) {
                                      return TextFormField(
                                        focusNode: _emailFocusNode,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            labelText: "Email",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            icon: Icon(Icons.alternate_email),
                                            border: InputBorder.none,
                                            errorText: snapshot.error),
                                        onChanged: userRegBloc.changeUserEmail,
                                        textInputAction: TextInputAction.next,
                                        validator: (email) =>
                                            EmailValidator.validate(email)
                                                ? null
                                                : "Invalid email address",
                                        onFieldSubmitted: (_) {
                                          try {
                                            fieldFocusChange(
                                                context,
                                                _emailFocusNode,
                                                _phoneFocusNode);
                                          } catch (signUpError) {
                                            if (signUpError
                                                is PlatformException) {
                                              if (signUpError.code ==
                                                  'ERROR_EMAIL_ALREADY_IN_USE') {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    // return object of type Dialog
                                                    return AlertDialog(
                                                      title: new Text(
                                                          "Alert Dialog title"),
                                                      content: new Text(
                                                          "Alert Dialog body"),
                                                      actions: <Widget>[
                                                        // usually buttons at the bottom of the dialog
                                                        new FlatButton(
                                                          child:
                                                              new Text("Close"),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            }
                                          }
                                          // fieldFocusChange(context,
                                          //     _emailFocusNode, _phoneFocusNode);
                                        },
                                        controller: emailController,
                                      );
                                    }),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: StreamBuilder<Object>(
                                    stream: userRegBloc.userPhone,
                                    builder: (context, snapshot) {
                                      return TextFormField(
                                        focusNode: _phoneFocusNode,
                                        autofocus: true,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                            labelText: "Phone",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            icon: Icon(
                                              MdiIcons.phone,
                                            ),
                                            border: InputBorder.none,
                                            errorText: snapshot.error),
                                        onChanged: userRegBloc.changeUserPhone,
                                        // controller: phoneController,
                                        // textInputAction: TextInputAction.done,
                                        // validator: (phone) {
                                        //   phoneController.text = phone;
                                        //   if (phone.length == 0)
                                        //     return 'Enter the phone number';
                                        //   else if (phone.length < 10 ||
                                        //       phone.length > 10)
                                        //     return 'Phone number should be of 10 digit';
                                        //   else
                                        //     return null;
                                        // },
                                        onFieldSubmitted: (_) {
                                          fieldFocusChange(
                                              context,
                                              _phoneFocusNode,
                                              _passwordFocusNode);
                                        },
                                      );
                                    }),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[200]))),
                                child: StreamBuilder<Object>(
                                    stream: userRegBloc.userPassword,
                                    builder: (context, snapshot) {
                                      return TextFormField(
                                        focusNode: _passwordFocusNode,
                                        autofocus: true,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            labelText: "Password",
                                            labelStyle:
                                                TextStyle(color: Colors.black),
                                            icon: Icon(
                                              Icons.lock_outline,
                                            ),
                                            border: InputBorder.none,
                                            errorText: snapshot.error),
                                        onChanged:
                                            userRegBloc.changeUserPassword,
                                        controller: passwordController,
                                        textInputAction: TextInputAction.done,
                                        validator: (password) {
                                          Pattern pattern = r'^.{6,12}$';
                                          RegExp regex = new RegExp(pattern);
                                          if (password.length == 0) {
                                            return 'Enter the password';
                                          } else if (password.length < 6) {
                                            return 'Password should have alteaset 6 characters';
                                          } else if (!regex.hasMatch(password))
                                            return 'Invalid password';
                                          else
                                            return null;
                                        },
                                        onFieldSubmitted: (_) {
                                          fieldFocusChange(
                                              context,
                                              _passwordFocusNode,
                                              _registerbtnFocusNode);
                                        },
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Material(
                                elevation: 5,
                                color: Colors.blue[300],
                                borderRadius: BorderRadius.circular(32.0),
                                child: StreamBuilder<bool>(
                                    stream: userRegBloc.submitValid,
                                    builder: (context, snapshot) {
                                      return MaterialButton(
                                        focusNode: _registerbtnFocusNode,
                                        autofocus: true,
                                        onPressed: !snapshot.hasData
                                            ? null
                                            : () {
                                                userRegBloc.add(
                                                    SignUpButtonPressedEvent(
                                                        context: context,
                                                        email: emailController
                                                            .text,
                                                        password:
                                                            passwordController
                                                                .text,
                                                        dob: dateCtl.text,
                                                        gender: gender,
                                                        phone: phoneController
                                                            .text,
                                                        username: nameController
                                                            .text));
                                              },
                                        minWidth: 200.0,
                                        height: 45.0,
                                        child: Text(
                                          "Register",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    ));
  }

  void _handleRadioValueChanged(int value) {
    setState(() {
      this._groupValue = value;
      if (value == 0) {
        nameController.text = nameController.text;
        dateCtl = dateCtl;
        gender = 'Male';
      } else {
        gender = 'Female';
      }
      print('genderrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrvalue:' + gender.toString());
    });
  }

  _genderRadio(int groupValue, handleRadioValueChanged) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        //MdiIcons.genderMaleFemale
        Row(
          children: <Widget>[
            Icon(
              MdiIcons.genderMaleFemale,
            ),
            //     Text(
            //   'Gender',
            //   style: new TextStyle(fontSize: 16.0),
            // ),
            Radio(
                value: 0,
                focusColor: Colors.blueAccent,
                focusNode: _genderFocusNode,
                groupValue: groupValue,
                onChanged: handleRadioValueChanged),
            Text(
              "Male",
              style: new TextStyle(
                fontSize: 14.0,
              ),
            ),
            Radio(
                value: 1,
                groupValue: groupValue,
                onChanged: handleRadioValueChanged),
            Text(
              "Female",
              style: new TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        )
      ]);
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue[300]),
        ),
        Container(margin: EdgeInsets.only(left: 5), child: Text("    Loading")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Widget buildInitialUi() {
  return Center(
    child: Text(""),
  );
}

Widget buildLoadingUi() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildFailureUi(String message) {
  return Center(
    child: Text(
      message,
      style: TextStyle(
        color: Colors.red,
      ),
    ),
  );
}

CustomAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    titlePadding: EdgeInsets.all(0),
    title: Container(
      //  color: Colors.blue[300],
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Error",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    ),
    content: Text("Kindly provide correct detials"),
    actions: [
      FlatButton(
        child: Text("OK"),
        onPressed: () {
          // buildInitialUi();
          Navigator.pushReplacement(
              context,
              new MaterialPageRoute(
                  builder: (context) => new LoginPageParent()));
          // Navigator.of(context).pop();
        },
      ),
    ],
  );

  return alert;
}

//                   try{
//                     if(_formKey.currentState.validate()){
//                     _formKey.currentState.save();

//  logindata.setString("emailpref", emailController.text);
// showAlertDialog(context);
//                     await locator.get<UserController>()
//                     .signUpWithEmailAndPassword (context,
//                     email: emailController.text,
//                     password:passwordController.text,
//                     username:nameController.text,
//                     gender: gender,
//                     phone: phoneController.text,
//                     dob: dateCtl.text);
// print('////////////////////hereeeeeeeeeeeee push    homeviewwww');

//                   // locator.get<AuthRepo>().updateDisplayName(nameController.text);
// print('///////before//////');

// final flag=await emailCheck(emailController.text);

//           print('///////before///////username:'+nameController.text);

// // // print("//fllllllllllllllag:"+flag.toString());
// //       if(flag)
// //       {
// //         print('//////////////username:'+nameController.text);
// //         Firestore.instance.collection("users").document(emailController.text).setData({
// //           "username":a,
// //           "email" :"emailController.text",
// //                    }    );

// // //                var myDatabase = Firestore.instance;
// // print("////////////////////////username:"+nameController.text);
// // print("////////////////////////username:"+emailController.text);
// // myDatabase.collection("users").add({
// //         "username": nameController.text,
// //         "email" :emailController.text,

// //       }).then((_) {
// //         print("////////////////////////One document added.pppppppppppppppp");

// //       });
//   // }
//   //  locator.get<AuthRepo>().getUser();

// FirebaseAuth dfdf = FirebaseAuth.instance;
//               dfdf.signOut();
//                Navigator.of(context).pop();

//               showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                        shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(20.0))),
//                                         titlePadding: EdgeInsets.all(0),
//                                         title: Container(
//                                         //  color: Colors.blue[300],
//                                           decoration: BoxDecoration(
//                 color: Colors.blue[300],
//                 borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//               ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(left:8.0,right:8.0),
//                                             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             //crossAxisAlignment: CrossAxisAlignment.stretch,
//                                             children:[Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: Text("Success",style: TextStyle(color:Colors.white),),
//                                             ),

//               ],),
//                                           ),
//                                         ),
//                                         content: Text("You are successfully registered"),
//                                         actions: [
//                                           FlatButton(
//                                             child: Text("OK"),
//                                             onPressed: () {
//                                                Navigator.of(context).pop();
//                                                 Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (context) => LoginView()),
//                       );

//                                     //          Navigator.of(context).pop();
//                                             },
//                                           ),
//                                         ],
//                                       );

//               // showDialog(
//               //                       context: context,
//               //                       builder: (BuildContext context) {
//               //                         return AlertDialog(
//               //                           title: Text("Success"),
//               //                           content: Text("You are successfully registered"),
//               //                           actions: [
//               //                             FlatButton(
//               //                               child: Text("OK"),
//               //                               onPressed: () {
//               //                                 Navigator.of(context).pop();
//               //                                 Navigator.of(context).pop();
//               //       //                           Navigator.pushReplacement(context,
//               //       //  MaterialPageRoute(builder: (context) => LoginView()),
//               //       //    );
//               //                                // Navigator.of(context).pop();
//               //                               },
//               //                             ),
//               //                           ],
//               //                         );
//                                      },
//                                  );

//                     }
//                   } catch(signUpError) {
//                    if(signUpError is PlatformException) {
//                     if(signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {

//                           showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                        shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(20.0))),
//                                         titlePadding: EdgeInsets.all(0),
//                                         title: Container(
//                                         //  color: Colors.blue[300],
//                                           decoration: BoxDecoration(
//                 color: Colors.blue[300],
//                 borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//               ),
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(left:8.0,right:8.0),
//                                             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             //crossAxisAlignment: CrossAxisAlignment.stretch,
//                                             children:[Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: Text("Error",style: TextStyle(color:Colors.white),),
//                                             ),

//               ],),
//                                           ),
//                                         ),
//                                         content: Text("Email Already in use"),
//                                         actions: [
//                                           FlatButton(
//                                             child: Text("OK"),
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                               Navigator.of(context).pop();
//                                             },
//                                           ),
//                                         ],
//                                       );

//               //
//               //
//               //
//               //
//                                     },
//                                   );
//                     }
//                  }
//                }
