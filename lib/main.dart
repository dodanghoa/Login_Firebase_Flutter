import 'package:flutter/material.dart';
import 'package:login/Home.dart';
import 'package:login/NhanVien.dart';
import 'package:login/SignUp.dart';
import 'package:login/conculation.dart';
import 'package:login/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// var count = 0;
// NhanVien _nhanVien = new NhanVien(hoTen: "hòa", age: 9);
//khai báo bdanh sách
//
//   List<NhanVien> nhanViens = <NhanVien>[NhanVien(hoTen: "Hòa",age: 8),NhanVien(hoTen: "Huy",age: 7),NhanVien(hoTen: "Đạt",age: 9)];

Future<void> main () async{
  // nhanViens.sort((a,b) => b.age-a.age );//Sắp xếp theo tuổi bé đến lớn
  // nhanViens.sort((a,b) => a.hoTen.toString().compareTo(b.hoTen.toString()) );//Sắp xếp theo tên bé đến lớn
  //
  // //Trả về list theo điều kiện
  // var filterNhanVien = nhanViens.where((element) => element.age == 7).toList();
  // // delete usinhgfilter
  // var deleteRest = nhanViens.where((element) => element.hoTen!="Huy").toList();
  // deleteRest.forEach((element) {print(element);});
  // //Lấy ra danh sách họ tên thôi
  // List hotenRes = nhanViens.map((e) => e.hoTen).toList();
  // // //
  // // Map<String,String> person = Map();
  // //   person["name"]="Hòa";
  // //   person["age"]="16";
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp() );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Login",
      theme: ThemeData(primaryColor: Colors.blue),
      home: Login(),
      routes:<String, WidgetBuilder>{
        "/SignUp":  (BuildContext context) => new SignUp(),
        "/Homes" :  (BuildContext context) => new  Home(),
        //add more routes here
      },
    );
  }
}




