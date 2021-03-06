
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]
);

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> handleSignIn() async {
  final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final FirebaseUser user = await _auth.signInWithCredential(credential);
  return user;
}

Future<FirebaseUser> handleEmailSignUp(String email, String password) async {
  final FirebaseUser user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  return user;
}


Future<FirebaseUser> handleEmailSignIn(String email, String password) async {
  final FirebaseUser user = await _auth.signInWithEmailAndPassword(email: email, password: password);
  return user;
}

Future<FirebaseUser> handleAnonUser() async {
  final FirebaseUser user = await _auth.signInAnonymously();
  return user;
}