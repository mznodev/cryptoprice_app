//import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  //sign in anonymous
  Future signInAnonimous() async {
    try {
      // AuthResult result = await _auth.signInAnonymously();
      //FirebaseUser user = result.user;
      // return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in whith email and password

  //register whith email and password

  //sign out

}
