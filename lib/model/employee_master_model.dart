// To parse this JSON data, do
//
//     final masterList = masterListFromJson(jsonString);

import 'dart:convert';

MasterList masterListFromJson(String str) => MasterList.fromJson(json.decode(str));

String masterListToJson(MasterList data) => json.encode(data.toJson());

String TABLE_NAME = "employee_master";

String COLUMN_ID = "id";
String COLUMN_EMP_ID = "emp_id";
String COLUMN_EMP_NAME = "name";
String COLUMN_EMP_MOBILE = "mobile_no";
String COLUMN_EMP_CODE = "code";
String COLUMN_EMP_IMG = "emp_img";
String COLUMN_EMP_FACE_ID = "face_id";
String COLUMN_EMP_DOB = "dob";
String COLUMN_HOST_FLAG = "host_flag";
String COLUMN_SYNC = "sync";

String table =  'CREATE TABLE $TABLE_NAME('
    '$COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,'
    ' $COLUMN_EMP_NAME TEXT,'
    '$COLUMN_EMP_MOBILE TEXT,'
    '$COLUMN_EMP_CODE TEXT,'
    '$COLUMN_EMP_FACE_ID TEXT,'
    '$COLUMN_EMP_IMG TEXT,'
    '$COLUMN_EMP_DOB TEXT,'
    ' $COLUMN_HOST_FLAG TEXT)';

class MasterList {
  MasterList({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Map<String, String>> data;

  factory MasterList.fromJson(Map<String, dynamic> json) => MasterList(
    status: json["status"],
    message: json["message"],
    data: List<Map<String, String>>.from(json["data"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v == null ? null : v)))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)))),
  };
}
