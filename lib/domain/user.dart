import 'package:firebase_auth/firebase_auth.dart';

class UserDom {
  String id;

  UserDom.fromFirebase(User user){
    id = user.uid;
  }
}