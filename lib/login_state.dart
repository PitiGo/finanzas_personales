import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState with ChangeNotifier {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    SharedPreferences _prefs;

  bool _loggedIn = false;
  bool _loading = false;
  FirebaseUser _user;
  //var userUidDummy='123456789';

  LoginState(){
      loginState();
  }

  // String  currentUser()=> _user.uid;
   FirebaseUser currentUser()=> _user;
  void login() async {
    _user = await _handleSignIn();
    notifyListeners();
    if (_user != null) {
      _loggedIn = true;
      notifyListeners();
    } else {
      _loggedIn = false;
    }
  }

  void logout() {
    _prefs.clear();
    _loggedIn = false;
    _googleSignIn.signOut();
    notifyListeners();
  }

  bool isLogged() => _loggedIn;
  bool isLoading() => _loading;

  Future<FirebaseUser> _handleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user;
  }

  

void loginState() async {
    _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey('isLoggedIn')) {
      _user = await _auth.currentUser();
      _loggedIn = _user != null;
      _loading = false;
      notifyListeners();
    } else {
      _loading = false;
      notifyListeners();
    }
  }
}


