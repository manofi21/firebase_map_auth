import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_map_auth/BLoC%20statement/service/auth_firebase.dart';
import 'package:firebase_map_auth/model/AuthMessage.dart';
import 'package:firebase_map_auth/model/locations.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:new_firebase/BLoC%20statement/service/auth_firebase.dart';
// import 'package:new_firebase/model/locations.dart';

import 'bloc.dart';

class BlocFirebaseBloc extends Bloc<BlocFirebaseEvent, BlocFirebaseState> {
  BlocFirebaseBloc() : super(LoadingState());
  FirebaseAuthnetication auth = FirebaseAuthnetication();

  @override
  Stream<BlocFirebaseState> mapEventToState(
    BlocFirebaseEvent event,
  ) async* {
    final _locationData = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (event is Register) {
      yield RegisterState();
    } else if (event is Login) {
      yield LoginState();
    } else if (event is CheckUser) {
      yield (await auth.isLoggedIn())
          ? Locations(LocationModel(
              username: auth.user.displayName,
              email: auth.user.email,
              lat: _locationData.latitude,
              long: _locationData.longitude))
          : LoginState();
    } else if (event is GoogleAuthEvent) {
      AuthMessage userFirebase = await auth.handleSignIn();
      if (userFirebase.message != null) yield ErrorState(userFirebase.message);
      yield LoadingState();
    } else if (event is GetUserLogin) {
      AuthMessage userFirebase = await auth.signIn(event.email, event.password);
      if (userFirebase.message != null) yield ErrorState(userFirebase.message);
      yield LoadingState();
      yield Locations(LocationModel(
          email: event.email,
          username: userFirebase.user.displayName,
          lat: _locationData.latitude,
          long: _locationData.longitude));
    } else if (event is GetUserRegister) {
      yield LoadingState();
      AuthMessage userFirebase = await auth.signUp(event.email, event.password);
      if (userFirebase.message != null) yield ErrorState(userFirebase.message);
      yield LoginState();
    } else if (event is LogOut) {
      yield LoadingState();
    }
  }
}
