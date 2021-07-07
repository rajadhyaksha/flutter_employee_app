import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_employee_app/Constant/common_function.dart';
import 'package:flutter_employee_app/model/employee_login_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Constant/Constant.dart';
import 'home.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;
  double _registerHeight = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                    image: NetworkImage( "https://images.unsplash.com/photo-1579202673506-ca3ce28943ef"),
              //  image: new AssetImage("images/aeologic_logo.png"),
                fit: BoxFit.cover)),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                  //  buttonSection(),
                ],
              ),
      ),
    );
  }

  signIn(String mobile_no, code) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'mobile_no': mobile_no,
      'code': code,
      'fcm_id': "12",
      'device_name': "",
      'device_token': ""
    };
    var jsonResponse = null;

    String uri = URL+"employee_login_v3.php";
    var response = await http.post(Uri.parse(uri), body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });

        // Unable to cast json here...

        if (jsonResponse['status'].toString() == "true") {

          final LoginList datalist = loginListFromJson(response.body);

        Common().storedetails(sharedPreferences,datalist);


          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => home()),
              (Route<dynamic> route) => false);
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

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        onPressed: emailController.text == "" || passwordController.text == ""
            ? null
            : () {
                setState(() {
                  _isLoading = true;
                });
                signIn(emailController.text, passwordController.text);
              },
        elevation: 0.0,
        color: Colors.yellow[700],
        child: Text("Login", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController resetPasscodeController = new TextEditingController();

  Container textSection() {
    return Container(
      transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
      decoration: BoxDecoration(
          color: Colors.yellow[400].withOpacity(_loginOpacity),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      margin: EdgeInsets.only(top: 200),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.black45,
            style: TextStyle(color: Colors.black45),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.black45),
              hintText: "Mobile Number",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45)),
              hintStyle: TextStyle(color: Colors.black45),
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.black45,
            obscureText: true,
            style: TextStyle(color: Colors.black45),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.black45),
              hintText: "PassCode",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45)),
                  hintStyle: TextStyle(color: Colors.black45),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10.0),
              child: Column(children: <Widget>[
            Text(
              "You do'nt have an account then,",
              style: TextStyle(color: Colors.black45),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => ResetPasscode()),
                    (Route<dynamic> route) => false);
              },
              child: Text("Register/Reset Passcode",
                  style: TextStyle(color: Colors.red)),
            ),
          ])),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40.0,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            margin: EdgeInsets.only(top: 15.0),
            child: RaisedButton(
              onPressed:
                  emailController.text == "" || passwordController.text == ""
                      ? null
                      : () {
                          setState(() {
                            _isLoading = true;
                          });
                          signIn(emailController.text, passwordController.text);
                        },
              elevation: 0.0,
              color: Colors.yellow[700],
              child: Text("Login", style: TextStyle(color: Colors.white70)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          )
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
      child: Text("Login",
          style: TextStyle(
              color: Colors.white70,
              fontSize: 40.0,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center),
    );
  }
}

class ResetPasscode extends StatefulWidget {
  @override
  Resetpass createState() => Resetpass();
}

class Resetpass extends State<ResetPasscode> {
  SharedPreferences sharedPreferences;
  bool _isLoading = false;
  double _loginWidth = 0;
  double _loginHeight = 0;
  double _loginOpacity = 1;

  double _loginYOffset = 0;
  double _loginXOffset = 0;
  double _registerYOffset = 0;
  double _registerHeight = 0;
  double verify = 0;
  bool mobileviewVisible = true;
  bool codeviewVisible = false;
  String message_id;

  @override
  void initState() {
    checkStatus();
    super.initState();
  }

  checkStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.centerLeft,
            image: AssetImage("assets/images/login_screen.png"),
          ),
              ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
          children: <Widget>[
            passCodeSection(),
            //  buttonSection(),
          ],
        ),
      ),
    );
  }
  final TextEditingController otpController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();

  Container passCodeSection() {
    return Container(
      transform: Matrix4.translationValues(_loginXOffset, _loginYOffset, 1),
      decoration: BoxDecoration(
          color: Colors.yellow[400].withOpacity(_loginOpacity),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      margin: EdgeInsets.only(top: 200),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
      child: Column(
        children: <Widget>[
          Visibility(
            visible: mobileviewVisible,
            child:
            TextFormField(
            controller: phoneController,
            cursorColor: Colors.black45,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
            style: TextStyle(color: Colors.black45),
            decoration: InputDecoration(
              icon: Icon(Icons.email, color: Colors.black45),
              hintText: "Mobile Number",

              border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black45)),
              hintStyle: TextStyle(color: Colors.black45),
            ),
          ),
    ),
          SizedBox(height: 30.0),
          Visibility(
            visible: codeviewVisible,
          child: TextFormField(
            controller: otpController,
            cursorColor: Colors.black45,
            obscureText: true,
            style: TextStyle(color: Colors.black45),
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.black45),
              hintText: "PassCode",
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black45)),
              hintStyle: TextStyle(color: Colors.black45),
            ),
          ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 40.0,
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            margin: EdgeInsets.only(top: 15.0),

    child: Visibility(
    visible: mobileviewVisible,
        child: RaisedButton(
        onPressed:
        phoneController.text == "" ? null : () {
        setState(() {
        _isLoading = true;
        });

        SendOtp(phoneController.text);
        },

        elevation: 0.0,
        color: Colors.yellow[700],
        child: Text("send otp", style: TextStyle(color: Colors.white70)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
           )
    ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 40.0,
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              margin: EdgeInsets.only(top: 15.0),

              child: Visibility(
                visible: codeviewVisible,
                child: RaisedButton(
                  onPressed:
                  otpController.text == "" ? null : () {
                    setState(() {
                      _isLoading = true;
                    });

                    verifyotp(otpController.text);
                  },

                  elevation: 0.0,
                  color: Colors.yellow[700],
                  child: Text("verify otp", style: TextStyle(color: Colors.white70)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              )
          )
        ],
      ),
    );

  }

  SendOtp(String mobile_no) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'mobile_number': mobile_no,
      'type': "login",
    };
    var jsonResponse = null;
    String uri = "https://smartknockpoc.proclivistech.com/APIs/request_otp.php";
    var response = await http.post(Uri.parse(uri), body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });

        // Unable to cast json here...

        if (jsonResponse['Status'].toString() == "Success") {
          print("sarvesh"+response.body);

          message_id = jsonResponse['Details'];
          codeviewVisible = true;
          mobileviewVisible = false;
          verify=1;
          Fluttertoast.showToast(
              msg: "sms send to your mobile number",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              textColor: Colors.black);

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

  verifyotp(String otp) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'otp': otp,
      'msg_id': message_id,
    };
    var jsonResponse = null;
    String uri = "https://smartknockpoc.proclivistech.com/APIs/verify_otp.php";
    var response = await http.post(Uri.parse(uri), body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });

        // Unable to cast json here...

        if (jsonResponse['Status'].toString() == "Success") {

          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => home()), (Route<dynamic> route) => false);

          Fluttertoast.showToast(
              msg: "verified your mobile number",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              textColor: Colors.black);
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
