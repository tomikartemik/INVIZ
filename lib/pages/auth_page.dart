import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invise_flutter/pages/auth_animation/FadeAnimation.dart';
import 'package:invise_flutter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invise_flutter/services/auth.dart';

import '../domain/user.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _username;
  String _password;
  bool showLogin = true;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {

    Widget _logo(){
      return Padding(
          padding: EdgeInsets.only(top: 100),
          child: Container(
              child: Align(
                  child: Text('INVIZ', style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white,)
                  ),
              )
          )
      );
    }

    Widget _input(Icon icon, String hint, TextEditingController controller, bool obscure){
      return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: TextStyle(fontSize: 20, color: Colors.white),
          decoration: InputDecoration(
              hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
              hintText: hint,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3)
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54, width: 1)
              ),
              prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: IconTheme(
                      data: IconThemeData(color: Colors.white),
                      child: icon
                  )
              )
          ),
        ),
      );
    }

    Widget _button(String text, void func()){
      return RaisedButton(
        splashColor: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor,
        color: Colors.white,
        child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor, fontSize: 20)
        ),
        onPressed: (){
          func();
        },
      );
    }

    Widget _form(String label, void func()){
      return Container(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: _input(Icon(Icons.account_circle), "USERNAME", _usernameController, false)
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: _input(Icon(Icons.lock), "PASSWORD", _passwordController, true)
            ),
            SizedBox(height: 20,),
            Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: _button(label, func)
                )
            )
          ],
        ),
      );
    }

    void _signInButtonAction() async{
      _username = _usernameController.text;
      _password = _passwordController.text;

      if (_username.isEmpty || _password.isEmpty) return;

      UserDom user = await _authService.logIn(_username.trim(), _password.trim());

      if(user == null){
        Fluttertoast.showToast(
            msg: "Can't SignIn you! Please check your username/password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else {
        _usernameController.clear();
        _passwordController.clear();
      }
    }

    void _registerButtonAction() async {
      _username = _usernameController.text;
      _password = _passwordController.text;

      if (_username.isEmpty || _password.isEmpty) return;

      UserDom user = await _authService.signIn(_username.trim(), _password.trim());

      if(user == null){
        Fluttertoast.showToast(
            msg: "Can't SignIn you! Please check your username/password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      } else {
        _usernameController.clear();
        _passwordController.clear();
      }
    }


    Widget _bottomWave() {
      return Expanded(
        child: Align(
          child: ClipPath(
            child: Container(
              color: Colors.white,
              height: 300,
            ),
            clipper: BottomWaveClipper(),
          ),
          alignment: Alignment.bottomCenter,
        ),
      );
    }

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            _logo(),
            SizedBox(height: 100,),
            (
                showLogin
                    ? Column(
                  children: <Widget>[
                    _form('LOGIN', _signInButtonAction),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                          child: Text('Register', style: TextStyle(fontSize: 20, color: Colors.white)),
                          onTap:() {
                            setState((){
                              showLogin = false;
                            });
                          }
                      ),
                    )
                  ],
                )
                    : Column(
                  children: <Widget>[
                    _form('REGISTER', _registerButtonAction),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                          child: Text('Login', style: TextStyle(fontSize: 20, color: Colors.white)),
                          onTap:() {
                            setState((){
                              showLogin = true;
                            });
                          }
                      ),
                    )
                  ],
                )
            ),
            _bottomWave()

          ],
        )
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}