
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserWelc extends StatefulWidget {
  final String userdata;
  
  
  UserWelc({this.userdata});
  @override
  _WelcomeUser createState() => _WelcomeUser();
}

class _WelcomeUser extends State<UserWelc> {
  String usern;
  var res,alldata,usr;
  final storage = new FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    usern=widget.userdata;
    
  }

 
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) =>  AlertDialog(
                title:  Text('Are you sure?'),
                content:  Text('Do you want to exit an App'),
                actions: <Widget>[
                   GestureDetector(
                    onTap: () => Navigator.of(context).pop(false),
                    child: roundedButton("No",Color(0xFF167F67),
                        const Color(0xFFFFFFFF)),
                  ),
                   GestureDetector(
                  
                   onTap: () => exit(0),
                    child: roundedButton(" Yes ",Color(0xFF167F67),
                        const Color(0xFFFFFFFF)),
                  ),
                ],
              ),
        ) ??
        false;
  }
  Widget roundedButton(String buttonLabel, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      padding: EdgeInsets.all(5.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }

// displayname()
// async {
//  res = await storage.read(key: 'userdata');
//  alldata= json.decode(res);
//      print(alldata['email']);
//      print(alldata['name']);
//      usr=alldata['name'].toString();
//      print(usr);
// }


  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onBackPressed,
    child: Scaffold(
      appBar: AppBar(
        title: Text('welcome'),
      ),
      body:Text('Welcome'),
    ),
    );  
  }
}