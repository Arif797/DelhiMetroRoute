import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tryLoginScreen/View/loginview.dart';
import 'package:tryLoginScreen/bloc/registerationBloc/user_reg_event.dart';
import 'package:tryLoginScreen/bloc/registerationBloc/user_reg_state.dart';

import 'package:tryLoginScreen/repository/auth_repo.dart';
import 'package:tryLoginScreen/view_controller/user_controller.dart';

class UserRegBloc extends Bloc<UserRegEvent, UserRegState> {
//UserRegBloc(UserLoadingState initialState) : super(UserRegInitialState());

  AuthRepo authRepo;
  UserController userController;

  UserRegBloc() : super(UserRegInitialState()) {
    authRepo = AuthRepo();
    userController = UserController();
  }

  final _userName = BehaviorSubject<String>();
  final _userEmail = BehaviorSubject<String>();
  final _userPhone = BehaviorSubject<String>();
  final _userPassword = BehaviorSubject<String>();

  //Get

  Stream<String> get userName => _userName.stream.transform(validateUserName);
  Stream<String> get userEmail =>
      _userEmail.stream.transform(validateUserEmail);
  Stream<String> get userPhone =>
      _userPhone.stream.transform(validateUserPhone);
  Stream<String> get userPassword =>
      _userPassword.stream.transform(validateUserPassword);

  Stream<bool> get submitValid => Rx.combineLatest4(
      userName,
      userEmail,
      userPhone,
      userPassword,
      (userName, userEmail, userPhone, userPassword) => true);

  //Set

  Function(String) get changeUserName => _userName.sink.add;
  Function(String) get changeUserEmail => _userEmail.sink.add;
  Function(String) get changeUserPhone => _userPhone.sink.add;
  Function(String) get changeUserPassword => _userPassword.sink.add;

  static get context => null;

  dispose() {
    _userName.close();
    _userEmail.close();
    _userPhone.close();
    _userPassword.close();
  }

  //Transformers
  int flag = 0;
  final validateUserName = StreamTransformer<String, String>.fromHandlers(
      handleData: (userName, sink) {
    if (userName == "") {
      sink.addError('Input field must requred');
    } else {
      sink.add(userName);
    }
  });

  final validateUserEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (userEmail, sink) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(userEmail);
    if (userEmail == "") {
      sink.addError('Input field must required');
    } else if (!emailValid) {
      sink.addError('Please enter valid Email');
    } else {
      sink.add(userEmail);
    }
  });

  final validateUserPhone = StreamTransformer<String, String>.fromHandlers(
      handleData: (userPhone, sink) {
    if (userPhone.length == 0) {
      sink.addError('Input field must required');
    } else if (userPhone.length < 10 || userPhone.length > 10)
      sink.addError('Phone number should be of 10 digit');
    else {
      sink.add(userPhone);
    }
  });

  final validateUserPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (userPassword, sink) {
    if (userPassword == "") {
      sink.addError('Input field must requred');
    } else if (userPassword.length < 7)
      sink.addError('Password length min: 7');
    else {
      sink.add(userPassword);
    }
  });

  submitUser(BuildContext context) {
    print('You are successfully registered..!!');
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (context) => LoginPageParent()));
  }

  @override
  Stream<UserRegState> mapEventToState(UserRegEvent event) async* {
    if (event is SignUpButtonPressedEvent) {
      try {
        //  yield UserLoadingState();
        var rr = await authRepo.signUpWithEmailAndPassword(
            email: event.email,
            password: event.password,
            dob: event.dob,
            gender: event.gender,
            username: event.username,
            phone: event.phone);
        if (rr == null) {
          showDialog(
            context: event.context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Error"),
                content: new Text("Email already in use!"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        } else {
          yield UserRegSuccessfulState();
        }
      } catch (signUpError) {
        print("in sinup button presssiiiiiiiiiiiii:" + signUpError.toString());
        yield UserRegFailureState(message: signUpError.toString());
        if (signUpError is PlatformException) {
          if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
            showDialog(
              context: event.context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text("Error"),
                  content: new Text("Email already in use!"),
                  actions: <Widget>[
                    new FlatButton(
                      child: new Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
      }
    }
  }
}
