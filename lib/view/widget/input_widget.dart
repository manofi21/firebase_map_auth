/* menambah contructor getter setter */
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_map_auth/BLoC%20statement/bloc/bloc_firebase_bloc.dart';
import 'package:firebase_map_auth/BLoC%20statement/bloc/bloc_firebase_event.dart';
import 'package:firebase_map_auth/BLoC%20statement/service/auth_firebase.dart';
import 'package:firebase_map_auth/model/getterSetter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:new_firebase/BLoC%20statement/bloc/bloc.dart';
// import 'package:new_firebase/BLoC%20statement/service/auth_firebase.dart';
// import 'package:new_firebase/model/getterSetter.dart';
// import 'package:email_validator/email_validator.dart';

FirebaseAuthnetication _fireAuth = FirebaseAuthnetication();

class WidgetsInputAuthnetication {
  GetLoginUsersInput controllerUserText;
  WidgetsInputAuthnetication(this.controllerUserText);

  Widget button(GlobalKey<FormState> keys, String title, BuildContext context) {
    final blocProvider = BlocProvider.of<BlocFirebaseBloc>(context);
    return RaisedButton(
        child: Text(title),
        onPressed: () {
          if (keys.currentState.validate()) {
            keys.currentState.save();
            (title == "Login")
                ? blocProvider.add(GetUserLogin(controllerUserText.strEmail,
                    controllerUserText.strPassword))
                : blocProvider.add(GetUserRegister(controllerUserText.strEmail,
                    controllerUserText.strPassword));
            controllerUserText.strEmail = "";
            controllerUserText.strPassword = "";
          }
        });
  }

  Widget googlAuthBtn(BuildContext context) {
    return FlatButton(
        color: Colors.purple,
        child: Text("Google Authentication"),
        onPressed: () {
          BlocProvider.of<BlocFirebaseBloc>(context).add(GoogleAuthEvent());
        });
  }

  InkWell changesAuth(
      GlobalKey<FormState> keys, String title, BuildContext context) {
    return InkWell(
      onTap: () {
        final bloc = BlocProvider.of<BlocFirebaseBloc>(context);
        title == "Login" ? bloc.add(Register()) : bloc.add(Login());
      },
      child:
          Text(title == "Login" ? "Click to registration" : "Click to login"),
    );
  }

// widget textfield untuk menempatkan function
  Widget field(Function saver, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 4),
      child: TextFormField(
        initialValue: "",
        onSaved: saver,
        obscureText: (hint != "Email"),
        validator: (values) {
          if (hint == "Email" && !(EmailValidator.validate(values))) {
            return "Something wrong in your gmail. Please try again";
          }
          if (values.isEmpty) {
            return "Please fill the blank text field";
          }
          if (values.length < 2) {
            return "too short. Please add some character";
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            suffixIcon: hint == "Email"
                ? Icon(Icons.supervised_user_circle)
                : Icon(Icons.lock),
            hoverColor: Colors.green,
            focusColor: Colors.green),
      ),
    );
  }

/* Form widget untuk menaruh key dan menempatkan semua widget ada pada satu tree/akses dalam key yang sama */
  Widget layout({GlobalKey<FormState> globalKey, List<Widget> theWidgets}) {
    return Form(
        /*key yang akan menyimpan input user*/
        key: globalKey,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              /*widget yang akan disusun agar menadapat satu key yang sama*/
              children: theWidgets),
        ));
  }
}

class UserLocationWidget {
  Widget buttonSingOut(BuildContext context) {
    return FlatButton(
        color: Colors.blueAccent,
        child: Row(
          children: [
            Icon(Icons.close, color: Colors.white),
            Text("Sign Out",
                style: TextStyle(
                  color: Colors.white,
                )),
          ],
        ),
        onPressed: () {
          _fireAuth.signOut().then((value) =>
              BlocProvider.of<BlocFirebaseBloc>(context).add(LogOut()));
        });
  }
}
