import 'package:firebase_map_auth/home.dart';
import 'package:firebase_map_auth/view/UserLocationPage.dart';
import 'package:firebase_map_auth/view/authenticationUserPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BLoC statement/bloc/bloc_firebase_bloc.dart';
import 'BLoC statement/bloc/bloc_firebase_event.dart';
import 'BLoC statement/bloc/bloc_firebase_state.dart';
import 'BLoC statement/service/auth_firebase.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final blocProvider = BlocFirebaseBloc();

  @override
  void dispose() {
    blocProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: "PlaceZ",
    //   home: Home(),
    //   debugShowCheckedModeBanner: false,
    // );
    return MaterialApp(
        home: Scaffold(
            body: BlocProvider(
                create: (context) => blocProvider,
                child: BloCWidgetsExecutio())));
  }
}

class BloCWidgetsExecutio extends StatelessWidget {
  final authCheck = FirebaseAuthnetication();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<BlocFirebaseBloc, BlocFirebaseState>(
          cubit: BlocProvider.of<BlocFirebaseBloc>(context),
          builder: (context, BlocFirebaseState state) {
            if (state is LoginState) {
              return LoginScreen();
            } else if (state is RegisterState) {
              return AuthenticationScreen("Register");
            } else if (state is LoadingState) {
              BlocProvider.of<BlocFirebaseBloc>(context).add(CheckUser());
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()],
              ));
            } else if (state is Locations) {
              return Center(child: UserLocationPage(state.locationsModel));
              // return Center(child: UserLocationPage());
            } else if (state is ErrorState) {
              // return LoginScreen();
              return Center(
                child: Text(state.errorText),
              );
            }
            return null;
          }),
    );
  }
}
