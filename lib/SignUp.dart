import 'dart:io';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//Khở tạo biến truy cập đến auth firebase
final FirebaseAuth _auth = FirebaseAuth.instance;
//Lớp render ra giao diện
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SignUp();
  }
}
//Lớp tạo giao diện
class _SignUp extends State<SignUp> with InputValidationMixin {

  late String email = "";
  late String pass = "";
  TextStyle buttonText = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: Colors.white,
  );
  RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
      side: BorderSide(color: Colors.blue, width: 1, style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(20));
  var emailListening = TextEditingController();
  var passListening = TextEditingController();
  var repassListening = TextEditingController();
  final logo = "assets/fb.png";
  final _formKey = GlobalKey<FormState>();

  InputDecoration create(title) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        labelText: title);
  }
  //Đăng ký
  //Đăng ký
  Future<bool> _register() async {
    bool res = false;
    if(repassListening.text==passListening.text)
      {
        final User? user = (await _auth.createUserWithEmailAndPassword(
          email: emailListening.text,
          password: passListening.text,
        ).catchError((on){
          Fluttertoast.showToast(
            msg: on.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
          );
        }))
            .user;
        if (user != null) {
          Fluttertoast.showToast(
            msg: "Đăng ký thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
          Navigator.pop(
              context
          );
          res = true;
        } else {
          Fluttertoast.showToast(
            msg: "Đăng ký thát bại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
          res = false;
        }
      }
    else{
      Fluttertoast.showToast(
        msg: "Mật khẩu không trùng khớp",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      res = false;
    }
    return res;
  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "My App",
        home: Scaffold(
          body: SafeArea(
              child: Form(
            key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text(
                      "Đăng kí tài khoản",
                      style: TextStyle(
                          fontSize: 30,
                          color: Color(0xffb1877f2),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: TextFormField(
                        onChanged: (text) => {
                          this.setState(() {
                            email = text;
                          })
                        },
                        controller: emailListening,
                        decoration: create(" Email"),
                        validator: (value) {
                          if (isEmailValid(value!))
                            return null;
                          else
                            return 'Enter a valid email';
                        },
                      )),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: TextFormField(
                        onChanged: (text) => {
                          this.setState(() {
                            pass = text;
                          })
                        },
                        inputFormatters: [],
                        controller: passListening,
                        decoration: create(" Mật khẩu"),
                        obscureText: true,
                        validator: (value) {
                          if (isPasswordValid(value!))
                            return null;
                          else
                            return 'Enter a valid password';
                        },
                      )),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: TextFormField(
                        onChanged: (text) => {
                          this.setState(() {
                            pass = text;
                          })
                        },
                        inputFormatters: [],
                        controller: repassListening,
                        decoration: create("Nhập Lại Mật khẩu"),
                        obscureText: true,
                        validator: (value) {
                          if (isrePasswordValid(value!,passListening.text))
                            return null;
                          else
                            return 'Enter a valid repassword';
                        },
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: FlatButton(
                      shape: buttonShape,
                      color: Color(0xffb42b72a),
                      padding:
                          EdgeInsets.symmetric(vertical: 19, horizontal: 125),
                      onPressed: () {
                        if(_formKey.currentState!.validate())
                          {
                            _register();
                          }
                      },
                      child: Text(
                        "Tạo tài khoản mới ",
                        style: buttonText,
                      ),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
          )
          ),
          resizeToAvoidBottomInset: false,
        ));
  }
}
mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length > 6;
  bool isrePasswordValid(String password,String repassword) => password.length > 6 &&password==repassword;
  bool isEmailValid(String email) {
    RegExp regex = new RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(email);
  }
}
