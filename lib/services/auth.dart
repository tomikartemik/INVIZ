import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:invise_flutter/constant/data.dart';
import 'package:invise_flutter/domain/user.dart';
import 'package:firebase_database/firebase_database.dart';


class AuthService {
  final firestoreInstance = FirebaseFirestore.instance;
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.reference();

  Future<UserDom> logIn(String username, String password) async {
    try{
      UserCredential result = await _fAuth.signInWithEmailAndPassword(email: username, password: password);
      User user = result.user;
      userData().getData();
      return UserDom.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future<UserDom> signIn(String username, String password) async {
    try{
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(email: username, password: password);
      User user = result.user;
      // databaseReference.child("Core").child("Staff").child(_fAuth.currentUser.uid).set({
      //   "Name": username,
      //   "Image": "https://images.unsplash.com/photo-1519531591569-b84b8174b508?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60",
      // });
      firestoreInstance.collection("Core").doc(_fAuth.currentUser.uid).set(
        {
          "Id":_fAuth.currentUser.uid.toString(),
          "Name": username,
          "Image": "https://images.unsplash.com/photo-1519531591569-b84b8174b508?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"
        }
      );
      firestoreInstance.collection("Core").doc(_fAuth.currentUser.uid).collection("Chats");
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