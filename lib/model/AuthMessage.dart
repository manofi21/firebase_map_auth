import 'package:firebase_auth/firebase_auth.dart';

class AuthMessage {
  final FirebaseUser user;
  final String message;
  AuthMessage({this.user, this.message});
}