import 'package:flutter/material.dart';
import 'package:invise_flutter/domain/user.dart';
import 'package:invise_flutter/pages/auth_page.dart';
import 'package:invise_flutter/pages/home_page.dart';
import 'package:provider/provider.dart';

class Landing extends StatelessWidget {
  const Landing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserDom user = Provider.of<UserDom>(context);
    final bool isLog = user != null;
    return isLog ? HomePage() : AuthPage();
  }
}
