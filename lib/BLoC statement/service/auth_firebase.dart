import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_map_auth/model/AuthMessage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthnetication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUser user;

  Future<AuthMessage> signIn(String email, String password) async {
    AuthResult result;
    //  = await _auth.signInWithEmailAndPassword(
    //     email: email, password: password);
    // FirebaseUser user = result.user;
    try {
      result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return AuthMessage(user: result.user);
    } catch (e) {
      return AuthMessage(message: e.toString());
    }
    // return user;
  }

  Future<AuthMessage> signUp(String email, String password) async {
    AuthResult result;
    //  = await _auth.createUserWithEmailAndPassword(
    //     email: email, password: password);
    // FirebaseUser user = result.user;
    try {
      result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return AuthMessage(user: result.user);
    } catch (e) {
      return AuthMessage(message: e.toString());
    }
    // return user.uid;
  }

  Future<bool> isLoggedIn() async {
    this.user = await _auth.currentUser();
    if (this.user == null) {
      return false;
    }
    return true;
  }

  Future<void> signOut() async {
    // GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await FirebaseAuth.instance
          .signOut()
          .then((value) => _googleSignIn.signOut());
    } catch (e) {
      print(e);
    }
  }

  Future<AuthMessage> handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser user;
    // =
    //     (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    try {
      user = (await _auth.signInWithCredential(credential)).user;
      return AuthMessage(user: user);
    } catch (e) {
      return AuthMessage(message: e.toString());
    }
    // return user;
  }
}
