import 'package:equatable/equatable.dart';
import 'package:firebase_map_auth/model/locations.dart';

abstract class BlocFirebaseState extends Equatable {
  const BlocFirebaseState();
}

class LoginState extends BlocFirebaseState {
  @override
  List<Object> get props => [];
}

class RegisterState extends BlocFirebaseState {
  @override
  List<Object> get props => [];
}

class LoadingState extends BlocFirebaseState {
  @override
  List<Object> get props => [];
}

class Locations extends BlocFirebaseState {
  final LocationModel locationsModel;
  Locations(this.locationsModel);

  @override
  List<Object> get props => [locationsModel];
}

class ErrorState extends BlocFirebaseState {
  final String errorText;
  ErrorState(this.errorText);

  @override
  List<Object> get props => [errorText];
}
