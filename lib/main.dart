
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_reg_app/login.dart';
import 'package:my_reg_app/register.dart';
import 'package:my_reg_app/welcome.dart';


void main(){
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterApp', 
       routes: <String, WidgetBuilder> {
    '/register': (BuildContext context) => Register(),
    '/login' : (BuildContext context) => MyLogin(),
    '/welcome' : (BuildContext context) => UserWelc()
  },
      home: SplashScreen()
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
var res,alldata;
final storage = new FlutterSecureStorage();

  startTimer() {
    Timer(Duration(seconds: 3), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }
navigateUser() async {
    res = await storage.read(key: 'userdata');
    if(res!=null)
    {
     alldata= json.decode(res);
     print(alldata['email']);
     print(alldata['name']);
     Navigator.pushReplacementNamed(context, '/welcome');
    }
    else
    {
      Navigator.pushReplacementNamed(context, '/register');
    }

}
  @override
  Widget build(BuildContext context) {
    return Container(
    child:startTimer(),
    );
  }
}



