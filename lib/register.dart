import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_reg_app/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:camera/camera.dart';


class Register extends StatefulWidget {
  @override
  _RegisterDerive createState() {
    return _RegisterDerive();
  }
}

class RegisterData {
  String name = '';
  String lname = '';
  String email = '';
  String pass1 = '';
  String phone = '';
}
class _RegisterDerive extends State<Register> {
   
  final storage = new FlutterSecureStorage();
  String pass;
  String pass1;
  String email;
  String val1;
  String val2;
  String val3;
  String user;
  String lname;
  String phno;
  String phone;
  var res,data;
  static final validCharacters = RegExp('[0-9]');
  static final validpass = RegExp('[!@#\$&*~]');
  static final validpass1 = RegExp('[A-Z]');
  static final validpass2 = RegExp('[a-z]');
  static final validpass3 = RegExp('[0-9]');
  static final phstart = RegExp(r"^[1-9]{1}[0-9]+");
  bool _obscureText = true;
  var passKey = GlobalKey<FormFieldState>();
  final _formKey = GlobalKey<FormState>();
  RegisterData objdata = RegisterData();

  String _validateEmail(email) {
    if (email.isEmpty) {
      // The form is empty
      return "Enter email address";
    }

    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,3}))$';

    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(email)) {
      // So, the email is valid
      return null;
    }

    
    return 'Email is not valid';
  }

  setterDataStorage(value) async {
    await storage.write(key: 'userdata', value: json.encode(value));
  }

  funreadval() async {
    res = await storage.read(key: 'userdata');
    var alldata= json.decode(res);
    print(alldata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Form'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 50.0, right: 50.0, bottom: 0, top: 40.0),
                  child: TextFormField(
                    
                    keyboardType: TextInputType.text,
                    onChanged: (val) {
                      setState(() {
                        user = val;
                        objdata.name = val;
                      });
                      // user = val;
                    },
                    validator: (user) {
                      if (user.isEmpty) {
                        return 'Please enter firstname';
                      }
                      if (user.length < 4) {
                        return 'Enter valid name.';
                      }
                      if (user.contains(validCharacters)) {
                        return 'Firstname does not contain integer value';
                      }

                      return null;
                    },

                    decoration: InputDecoration(
                        labelText: 'Firstname',
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          borderSide: new BorderSide(),
                        ),
                        hintText: 'Enter a Firstname'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 50.0, right: 50.0, bottom: 0, top: 10.0),
                  child: TextFormField(
                    

                    validator: (lname) {
                      if (lname.isEmpty) {
                        return 'Please enter Lastname';
                      }
                      if (lname.length < 4) {
                        return 'Enter valid name.';
                      }
                      if (lname.contains(validCharacters)) {
                        return 'Lastname does not contain integer value';
                      }

                      return null;
                    },

                    decoration: InputDecoration(
                        labelText: 'Lastname',
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          borderSide: new BorderSide(),
                        ),
                        hintText: 'Enter Lastname'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 50.0, right: 50.0, bottom: 0, top: 10.0),
                  child: TextFormField(
                    // decoration: const InputDecoration(labelText: 'Name'),
                    keyboardType: TextInputType.text,
                    onChanged: (val1) {
                      email = val1;
                      objdata.email = val1;
                    },
                    validator: _validateEmail,

                    decoration: InputDecoration(
                        labelText: 'Email Id',
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(20.0),
                          borderSide: new BorderSide(),
                        ),
                        hintText: 'Enter a Email Id'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 50.0, right: 50.0, bottom: 0, top: 20.0),
                  child: TextFormField(
                    key: passKey,
                    //  obscureText: true,
                    obscureText: _obscureText,
                    onChanged: (val2) {
                      pass1 = val2;
                      objdata.pass1 = val1;
                    },
                    validator: (pass1) {
                      if (pass1.isEmpty) {
                        return 'Please enter password';
                      }
                      if (!(pass1.length > 8) && pass1.isNotEmpty) {
                        return "Password should contain more then 8 character";
                      }
                      if (!(pass1.contains(validpass))) {
                        return 'password should contain atleast one special characters';
                      }
                      if (!(pass1.contains(validpass1))) {
                        return 'password should contain atleast one capital and small letter ';
                      }
                      if (!(pass1.contains(validpass2))) {
                        return 'password should contain atleast one small letter ';
                      }
                      if (!(pass1.contains(validpass3))) {
                        return 'password should contain atleast 1 integer value ';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Enter your password',
                      suffixIcon: new GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: new Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 50.0, right: 50.0, bottom: 0, top: 20.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (pass) {
                      if (pass.isEmpty) {
                        return 'please re-enter password';
                      }
                      if (pass != passKey.currentState.value) {
                        return 'Passwords do not match';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Re-Enter your password', //Pr@tik123
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 50.0, right: 50.0, bottom: 0, top: 20.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onChanged: (val3) {
                      phno = val3;
                      objdata.phone = val3;
                    },
                    validator: (phno) {
                      if (phno.isEmpty) {
                        return 'Please enter your phone number.';
                      }
                      if ((phno.length > 10) || (phno.length < 10)) {
                        return 'Enter valid phone number';
                      }
                      if (!(phno.contains(validpass3))) {
                        return 'phone number should not contain contain alphabets or special characters';
                      }
                      if (!(phno.contains(phstart))) {
                        return 'mobile number cannot start with 0.';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Phone no.',
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                  ),
                ),
            Container(
              height:100,
              width:100,
              color: Colors.amber,
               margin: const EdgeInsets.all(10.0),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                 // child: _cameraPreviewWidget(),
                ),
              ),
              // decoration: BoxDecoration(
              //   color: Colors.black,
              //   border: Border.all(
              //     color: controller != null && controller.value.isRecordingVideo
              //         ? Colors.redAccent
              //         : Colors.grey,
              //     width: 3.0,
              //   ),
              // ),
            ),
         
             
                new RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await setterDataStorage({
                        'name': objdata.name,
                        'email': objdata.email,
                        'phone no': objdata.phone
                      });
                      
                      funreadval();

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyLogin(
                          email: '$email',
                          pass1: '$pass1',
                          user: '$user',
                         
                        ),
                      )
                     
                      );
                    }
                  },
                  textColor: Colors.white,
                  color: Colors.red,
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(
                    "Submit",
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


