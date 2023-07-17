import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<User> signIn(String email, String password);

  Future<Map<int, String>> signUp(String email, String password);

  Future<User> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> signIn(String email, String password) async {

    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    User user = _firebaseAuth.currentUser!;
    return user;
  }

  Future<Map<int, String>> signUp(String email, String password) async {

    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    if (_firebaseAuth.currentUser == null){
      return {
        1:"Unable to create user."
      };
    }
    else{
      return {
        0:_firebaseAuth.currentUser!.uid
      };
    }
  }

  Future<User> getCurrentUser() async {
    User user = _firebaseAuth.currentUser!;
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    User user = _firebaseAuth.currentUser!;
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    User user = _firebaseAuth.currentUser!;
    return user.emailVerified;
  }
}