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
class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}
RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
    side: BorderSide(color:Colors.white, style: BorderStyle.solid),
    borderRadius: BorderRadius.circular(10));
TextStyle buttonText = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: Colors.white,
);
TextStyle titleText = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  color: Colors.black,
);
//Lớp tạo giao diện
class _Home extends State<Home>  {

  final _formKey = GlobalKey<FormState>();
  InputDecoration create(title) {
    return InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        labelText: title);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "My App",
        home: Scaffold(
          body: SafeArea(
              child:Center(
                child: Column(
                  children: [Padding(padding: EdgeInsets.symmetric(vertical: 10)),Text(
                    "Xin chào  "+ _auth.currentUser!.email.toString(),
                    style: titleText,
                  ),Padding(padding: EdgeInsets.symmetric(vertical: 10)),FlatButton(
                    shape: buttonShape,
                    color: Color(0xffb42b72a),
                    onPressed: () {
                      _formKey.currentState!.save();
                      Fluttertoast.showToast(
                        msg: "oke",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                      );
                    },
                    child: Builder(
                      builder: (context) => FlatButton(
                        padding:
                        EdgeInsets.symmetric(vertical: 19, horizontal: 50),
                        onPressed: () {
                          _auth.signOut();
                          Fluttertoast.showToast(
                            msg: "Đã đăng xuất",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                          );
                          Navigator.of(context, rootNavigator: true).pop(context);
                        },
                        child: Text(
                          "Đăng xuất",
                          style: buttonText,
                        ),
                      ),
                    ),
                  ),],
                )
              ),),
          resizeToAvoidBottomInset: false,
        ));
  }
}

