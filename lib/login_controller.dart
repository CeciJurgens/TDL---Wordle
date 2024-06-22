import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier{
  final GoogleSignIn googleSignIn = GoogleSignIn();
  String? name, imageUrl, userEmail, uid;

  Future<User?> signInWithGoogle() async {
    await Firebase.initializeApp();
    User? user;
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential = await auth.signInWithPopup(authProvider);
      user = userCredential.user;
    } catch (e) {
      print(e);
    }

    if (user != null) {
      uid = user.uid;
      name = user.displayName;
      userEmail = user.email;
      imageUrl = user.photoURL;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('auth', true);
      print("name: $name");
      print("userEmail: $userEmail");
      print("imageUrl: $imageUrl");
    }
    return user;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    name = null;
    imageUrl = null;
    userEmail = null;
    uid = null;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', false);

    notifyListeners();
  }

}