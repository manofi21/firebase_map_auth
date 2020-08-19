import 'package:equatable/equatable.dart';
abstract class BlocFirebaseEvent extends Equatable {
  const BlocFirebaseEvent();
}

class Register extends BlocFirebaseEvent {
  @override
  List<Object> get props => [];
}

class Login extends BlocFirebaseEvent {
  @override
  List<Object> get props => [];
}

class GoogleAuthEvent extends BlocFirebaseEvent {
  @override
  List<Object> get props => [];
}


class GetUserRegister extends BlocFirebaseEvent {
  final String email, password;
  GetUserRegister(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class GetUserLogin extends BlocFirebaseEvent {
  final String email, password;
  GetUserLogin(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class CheckUser extends BlocFirebaseEvent {
  @override
  List<Object> get props => [];
}

class LogOut extends BlocFirebaseEvent {
  @override
  List<Object> get props => [];
}