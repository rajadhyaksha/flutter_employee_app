// To parse this JSON data, do
//
//     final loginList = loginListFromJson(jsonString);

import 'dart:convert';

LoginList loginListFromJson(String str) => LoginList.fromJson(json.decode(str));

String loginListToJson(LoginList data) => json.encode(data.toJson());

class LoginList {
  LoginList({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  Data data;

  factory LoginList.fromJson(Map<String, dynamic> json) => LoginList(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.empId,
    this.geofencingCheck,
    this.employeeNumber,
    this.installationId,
    this.employeeName,
    this.mobileNo,
    this.emailId,
    this.address,
    this.gender,
    this.dateOfBirth,
    this.code,
    this.faceId,
    this.customerName,
    this.customerId,
    this.customerMobile,
    this.collectionId,
    this.shiftId,
    this.shiftBeginTime,
    this.shiftEndTime,
    this.deptId,
    this.deptName,
    this.mobileAppEnabled,
    this.profileImage,
    this.routingFlag,
    this.emailFlag,
  });

  int empId;
  String geofencingCheck;
  String employeeNumber;
  int installationId;
  String employeeName;
  int mobileNo;
  String emailId;
  String address;
  String gender;
  DateTime dateOfBirth;
  String code;
  String faceId;
  String customerName;
  int customerId;
  String customerMobile;
  String collectionId;
  int shiftId;
  String shiftBeginTime;
  String shiftEndTime;
  int deptId;
  String deptName;
  String mobileAppEnabled;
  String profileImage;
  String routingFlag;
  String emailFlag;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    empId: json["emp_id"],
    geofencingCheck: json["geofencing_check"],
    employeeNumber: json["employee_number"],
    installationId: json["installation_id"],
    employeeName: json["employee_name"],
    mobileNo: json["mobile_no"],
    emailId: json["email_id"],
    address: json["address"],
    gender: json["gender"],
    dateOfBirth: DateTime.parse(json["date_of_birth"]),
    code: json["code"],
    faceId: json["face_id"],
    customerName: json["customer_name"],
    customerId: json["customer_id"],
    customerMobile: json["customer_mobile"],
    collectionId: json["collection_id"],
    shiftId: json["shift_id"],
    shiftBeginTime: json["shift_begin_time"],
    shiftEndTime: json["shift_end_time"],
    deptId: json["dept_id"],
    deptName: json["dept_name"],
    mobileAppEnabled: json["mobile_app_enabled"],
    profileImage: json["profile_image"],
    routingFlag: json["routing_flag"],
    emailFlag: json["email_flag"],
  );

  Map<String, dynamic> toJson() => {
    "emp_id": empId,
    "geofencing_check": geofencingCheck,
    "employee_number": employeeNumber,
    "installation_id": installationId,
    "employee_name": employeeName,
    "mobile_no": mobileNo,
    "email_id": emailId,
    "address": address,
    "gender": gender,
    "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "code": code,
    "face_id": faceId,
    "customer_name": customerName,
    "customer_id": customerId,
    "customer_mobile": customerMobile,
    "collection_id": collectionId,
    "shift_id": shiftId,
    "shift_begin_time": shiftBeginTime,
    "shift_end_time": shiftEndTime,
    "dept_id": deptId,
    "dept_name": deptName,
    "mobile_app_enabled": mobileAppEnabled,
    "profile_image": profileImage,
    "routing_flag": routingFlag,
    "email_flag": emailFlag,
  };
}
