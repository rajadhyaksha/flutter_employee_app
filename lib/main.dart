import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_employee_app/Constant/Constant.dart';
import 'package:flutter_employee_app/home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Code Land",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: ThemeData(
          accentColor: Colors.white70
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getInt(INSTALLATION_ID) == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }else{
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => home()), (Route<dynamic> route) => false);

    }
  }

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, checkLoginStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      backgroundColor: appbarColor,
       body: Container(
         child:Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Container(
               alignment: Alignment.center,
               child: Center(
                 child: Image.asset("assets/images/logo.png"),
               ),
             ),
             Text("Employee App",
                 style: TextStyle(
                     color: Colors.black,
                     fontSize: 20.0,
                     fontWeight: FontWeight.bold),textAlign: TextAlign.center),


           ],
       )
    )
    );
  }




}