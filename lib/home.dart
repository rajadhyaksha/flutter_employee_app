import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_employee_app/Constant/common_function.dart';
import 'package:flutter_employee_app/Constant/loginjson.dart';
import 'package:flutter_employee_app/model/employee_login_model.dart';
import 'package:flutter_employee_app/model/employee_master_model.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constant/Constant.dart';
import 'category_card.dart';
import 'database/database_helper.dart';
import 'login.dart';

class home extends StatelessWidget {
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
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MainPage> {
  SharedPreferences sharedPreferences;
  bool _isLoading = false;
  DatabaseHelper databaseHelper;
  var now = new DateTime.now();
  var formatter;
  String formattedDate;

  @override
  void initState() {
    checkStatus();
    databaseHelper = DatabaseHelper();
    formatter = new DateFormat('yyyy-MM-dd');
    formattedDate = formatter.format(now);

    //if(sharedPreferences.getString(LOGIN_API_CALL_DATE) == formattedDate) {
       loginData();
  //  }
    EmployeeMaster();
    super.initState();
  }

  checkStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .30,
            decoration: BoxDecoration(
              color: Color(0xFFFF940B),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Color(0xFFFDCD71),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/icons/menu.svg"),
                    ),
                  ),
                  Text(
                    "AMS VMS Enterprises",
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .copyWith(fontWeight: FontWeight.w400),
                  ),

                  Expanded(
                    child: GridView.count(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      crossAxisCount: 3,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          title: "Punch",
                          svgSrc: "assets/icons/face.png",
                          press: () {},
                        ),
                        CategoryCard(
                          title: "Leave",
                          svgSrc: "assets/icons/exit.png",
                          press: () {},
                        ),
                        CategoryCard(
                          title: "Attendance",
                          svgSrc: "assets/icons/attendance.png",
                          press: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  EmployeeMaster() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'installation_id': sharedPreferences.getInt(INSTALLATION_ID).toString(),
    };
    var jsonResponse = null;
    String uri = URL+"ams_get_emp_mast.php";
    var response = await http.post(Uri.parse(uri), body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
       final MasterList datalist = masterListFromJson(response.body);

        // Unable to cast json here...

        if (jsonResponse['Status'].toString() == "Success") {

          databaseHelper.insertNote(datalist);

        } else {
          Fluttertoast.showToast(
              msg: jsonResponse['message'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              textColor: Colors.black);
        }
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.body);
    }
  }

  loginData() async {

      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      Map data = {
        'mobile_no': sharedPreferences.getString(mobile_no),
        'code': sharedPreferences.getString(code),
        'fcm_id': "12",
        'device_name': "",
        'device_token': ""
      };
      var jsonResponse = null;
      String uri = URL + "employee_login_v3.php";
      var response = await http.post(Uri.parse(uri), body: data);
      if (response.statusCode == 200) {
        jsonResponse = json.decode(response.body);
        if (jsonResponse != null) {
          setState(() {
            _isLoading = false;
          });

          // Unable to cast json here...

          if (jsonResponse['Status'].toString() == "Success") {

            final LoginList loginlist = loginListFromJson(response.body);
            Common().storedetails(sharedPreferences, loginlist);

            //   message_id = jsonResponse['Details'];
            //   codeviewVisible = true;
            //    mobileviewVisible = false;
            //   verify=1;


          } else {
            Fluttertoast.showToast(
                msg: jsonResponse['message'],
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                textColor: Colors.black);
          }
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        print(response.body);
      }
  }

}
