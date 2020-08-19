import 'package:firebase_map_auth/BLoC%20statement/service/validation.dart';
import 'package:firebase_map_auth/model/getterSetter.dart';
import 'package:firebase_map_auth/view/widget/input_widget.dart';
import 'package:flutter/material.dart';
// import 'package:new_firebase/BLoC%20statement/service/validation.dart';
// import 'package:new_firebase/model/getterSetter.dart';
// import 'package:new_firebase/view/widget/input_widget.dart';

class AuthenticationScreen extends StatefulWidget {
  final String title;
  const AuthenticationScreen(this.title);
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  GetLoginUsersInput parts = new GetLoginUsersInput();
  final globalKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    WidgetsInputAuthnetication wrap = WidgetsInputAuthnetication(parts);
    Valid val = new Valid(parts);
    return Scaffold(
      body: Container(
          child: wrap.layout(globalKey: globalKey, theWidgets: [
        Text("${widget.title}"),
        SizedBox(height: 20,),
        Text("Email"),
        wrap.field(val.saveUsername, "Email"),
        Text("Password"),
        wrap.field(val.savePassword, "Password"),
        wrap.button(globalKey, widget.title, context),
        wrap.googlAuthBtn(context),
        wrap.changesAuth(globalKey,widget.title,context)
      ])),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GetLoginUsersInput parts = new GetLoginUsersInput();
  final globalKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    WidgetsInputAuthnetication wrap = WidgetsInputAuthnetication(parts);
    Valid val = new Valid(parts);
    return Scaffold(
      body: Container(
          child: wrap.layout(globalKey: globalKey, theWidgets: [
        Text("Login"),
        SizedBox(height: 20,),
        Text("Email"),
        wrap.field(val.saveUsername, "Email"),
        Text("Password"),
        wrap.field(val.savePassword, "Password"),
        wrap.button(globalKey, "Login", context),
        wrap.googlAuthBtn(context),
        wrap.changesAuth(globalKey,"Login",context)
      ])),
    );
  }
}