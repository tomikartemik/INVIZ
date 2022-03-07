import 'package:firebase_auth/firebase_auth.dart';
import 'package:invise_flutter/domain/user.dart';

class AuthService {

  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<UserDom> logIn(String username, String password) async {
    try{
      UserCredential result = await _fAuth.signInWithEmailAndPassword(email: username, password: password);
      User user = result.user;
      return UserDom.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future<UserDom> signIn(String username, String password) async {
    try{
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(email: username, password: password);
      User user = result.user;
      return UserDom.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<UserDom> get currentUser {
    return _fAuth.authStateChanges().map((User user) => user != null ? UserDom.fromFirebase(user) : null);
  }

}