import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';




class Cricle_Outline extends StatefulWidget {
  @override
  _circle createState() => _circle();
}

class _circle extends State<Cricle_Outline> {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return
      Container(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            border: Border.all(color: Colors.yellow[700]),
            shape: BoxShape.circle,
          ),
          height: 30.0,
          width: 30.0,
          child: Center(
            // Your Widget
          ),
        ),
      );
  }
}

