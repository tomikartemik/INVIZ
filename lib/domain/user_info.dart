import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class user_info {

  String image;
  String name;
  user_info(this.image, this.name);
  factory user_info.fromJson(dynamic json) {
    return user_info(json['Name'] as String, json['Image'] as dynamic);

  }
}

class getUserInfoFromJson {
  final databaseReference = FirebaseDatabase.instance.ref('Core/Staff/${FirebaseAuth.instance.currentUser.uid}');

  getData() async {

    DatabaseEvent event = await databaseReference.once();
    user_info user_inf = user_info.fromJson(event.snapshot.value);
    return user_inf.image;
  }
}