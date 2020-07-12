import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:my_reg_app/register.dart';
import 'package:my_reg_app/welcome.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class MyLogin extends StatefulWidget {
  final String email;
  final String pass1;
  final String user;
 
  
  MyLogin({this.email, this.pass1,this.user});
  @override
  _MyLoginDerive createState() {
    return _MyLoginDerive();
  }
}

class _MyLoginDerive extends State<MyLogin> {
 final storage = new FlutterSecureStorage();
  var res;
  static final validCharacters = RegExp('[0-9]');
  static final validpass = RegExp('[!@#\$&*~]');
  static final validpass1 = RegExp('[A-Z]');
  static final validpass2 = RegExp('[a-z]');
  static final validpass3 = RegExp('[0-9]');
  final _formKey = GlobalKey<FormState>();
 String userdata;
 var alldata;

@override
  void initState() {
    super.initState();
    userdata=widget.user;
  }
  getterDataStorage()
  async {
    
    res = await storage.read(key: 'userdata');
     alldata= json.decode(res);
    print(alldata['email']);

    if(alldata['email']==widget.email)
    {
      print('login successfully');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Form'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: new EdgeInsets.symmetric(vertical: 50.0),
                    height: 100,
                    width: 100,
                    color: Colors.black,
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyI8FQwQLlJzrTOym-qRB7osuSBKgtICb6Dnl64cre0f1Q0YiZpQ&s',
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      left: 50.0, right: 50.0, bottom: 0, top: 10.0),
                  child: TextFormField(
                    //  controller: _textFieldController,
                    // decoration: const InputDecoration(labelText: 'Name'),
                    keyboardType: TextInputType.text,
                    validator: (mail) {
                      if (mail.isEmpty) {
                        return 'Please enter username';
                      }
                     
                      
                      if (!(mail.contains(widget.email))) {
                       
                        return 'email id is not correct';
                      }

                      return null;
                    },

                    decoration: InputDecoration(
                        labelText: 'Username',
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        hintText: 'Enter a Username'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 50.0, right: 50.0, bottom: 0, top: 20.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (passwd) {
                      if (passwd.isEmpty) {
                        return 'Please enter password';
                      }
                      
                      if (!(passwd.contains(widget.pass1))) {
                       
                        return 'password is not correct';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter your password',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                new RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      getterDataStorage();
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) =>
                      //         UserWelc(userdata: '$userdata'),
                      //         maintainState: false,
                      //   ));

                          Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) =>
                              UserWelc(userdata: '$userdata'),
                              maintainState: false,
                        ));     
                      
                    }
                  },
                  textColor: Colors.white,
                  color: Colors.red,
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "login",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
