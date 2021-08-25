import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login/Home.dart';
import 'SignUp.dart';

//Khở tạo biến truy cập đến auth firebase
final FirebaseAuth _auth = FirebaseAuth.instance;

//Lớp render ra giao diện
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }
}

//Lớp tạo giao diện
class _Login extends State<Login> with InputValidationMixin {

  late String email = "";
  late String pass = "";
  User? user = _auth.currentUser;
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
  final logo = "assets/fb.png";
  final _formKey = GlobalKey<FormState>();
  InputDecoration create(title) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        labelText: title);
  }
//Đăng ký
  Future<bool> _login() async {
    bool res = true;
    final User? user = (await _auth.signInWithEmailAndPassword(
      email: emailListening.text,
      password: passListening.text,
    ).catchError((onError){
      Fluttertoast.showToast(
        msg: "Đăng nhập không thành công! " + onError.toString() ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }))
        .user;
    if (user != null) {
      Fluttertoast.showToast(
        msg: "Đăng nhập thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      res = true;
      Navigator.of(context).pushNamed('/Homes');
    } else {
      Fluttertoast.showToast(
        msg: "Sai tài khoản hoặc mật khẩu",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      res = false;
    }
    return res;
  }


  _onLayoutDone(_) {

  }

  @override
  void initState() {

      if(_auth.currentUser!=null)
      {
        Timer.run(() { // import 'dart:async:
          Navigator.of(context).pushNamed('/Homes');
        });
      }
    WidgetsBinding.instance!.addPostFrameCallback(_onLayoutDone);
    super.initState();
  }
  @override
  // TODO: implement context
  BuildContext get context => super.context;
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
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
                  child: Image.asset(
                    logo,
                    width: 100,
                    height: 100,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text(
                    "Facebook",
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
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child:Builder(
                    builder: (context) => FlatButton(
                      shape: buttonShape,
                      color: Color(0xffb1877f2),
                      padding:
                      EdgeInsets.symmetric(vertical: 19, horizontal: 140),
                      onPressed: () {
                         _login();
                      },
                      child: Text(
                        "Đăng Nhập",
                        style: buttonText,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text(
                    "Quên mật khẩu ?",
                    style: TextStyle(fontSize: 16, color: Color(0xffb1877f2)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Builder(
                    builder: (context) => FlatButton(
                      shape: buttonShape,
                      color: Color(0xffb42b72a),
                      padding:
                          EdgeInsets.symmetric(vertical: 19, horizontal: 100),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp()),
                        );
                      },
                      child: Text(
                        "Tạo tài khoản mới ",
                        style: buttonText,
                      ),
                    ),
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          )),
          resizeToAvoidBottomInset: false,
        ));
  }
}

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length > 6;

  bool isEmailValid(String email) {
    RegExp regex = new RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regex.hasMatch(email);
  }
}
