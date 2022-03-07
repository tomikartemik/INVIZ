import 'package:flutter/material.dart';
import 'package:invise_flutter/pages/auth_page.dart';
import 'package:invise_flutter/pages/home_page.dart';

class Landing extends StatelessWidget {
  const Landing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isLog = false;
    return isLog ? HomePage() : AuthPage();
  }
}
