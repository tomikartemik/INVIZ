import 'package:flutter/material.dart';
import 'package:invise_flutter/domain/user.dart';
import 'package:invise_flutter/pages/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:invise_flutter/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StreamProvider<UserDom>.value(
    value: AuthService().currentUser,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Landing(),
    ),
  ));
}