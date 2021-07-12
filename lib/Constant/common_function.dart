
import 'package:flutter_employee_app/model/employee_login_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Constant.dart';

class Common{

   storedetails(SharedPreferences sharedPreferences,LoginList loginVo) {
     if(loginVo.data.mobileAppEnabled=="yes") {
     //  setFcm()

       sharedPreferences.setString(CUSTOMER_Mobile, loginVo.data.customerMobile);
       sharedPreferences.setInt(EMPLOYEE_ID, loginVo.data.empId);
       sharedPreferences.setString(EMPLOYEE_NUMBER, loginVo.data.employeeNumber);
       sharedPreferences.setString(EMPLOYEE_NAME, loginVo.data.employeeName);
       sharedPreferences.setInt(INSTALLATION_ID, loginVo.data.installationId);
       sharedPreferences.setInt(EMPLOYEE_MOBILE_N0, loginVo.data.mobileNo);
       sharedPreferences.setString(EMAIL_ID, loginVo.data.emailId);
       sharedPreferences.setString(ADDRESS, loginVo.data.address);
       sharedPreferences.setString(GENDER, loginVo.data.gender);
       sharedPreferences.setString(DATE_OF_BIRTH, loginVo.data.dateOfBirth.toString());
       sharedPreferences.setString(MEMBER_EMAIL_FLAG, loginVo.data.emailFlag);
       sharedPreferences.setString(MEMBER_LAST_SYNC, "");
       sharedPreferences.setString(CODE, loginVo.data.code);
       sharedPreferences.setString(FACE_ID, loginVo.data.faceId);
       sharedPreferences.setString(CUSTOMER_NAME, loginVo.data.customerName);
       sharedPreferences.setInt(CUSTOMER_ID, loginVo.data.customerId);
       sharedPreferences.setInt(SHIFT_ID, loginVo.data.shiftId);
       sharedPreferences.setString(SHIFT_BEGIN_TIME, loginVo.data.shiftBeginTime);
       sharedPreferences.setString(SHIFT_END_TIME, loginVo.data.shiftEndTime);
       sharedPreferences.setString(geofencing_check, loginVo.data.geofencingCheck);
       sharedPreferences.setInt(DEPT_ID, loginVo.data.deptId);
       sharedPreferences.setString(mobile_app_enabled, loginVo.data.mobileAppEnabled);
       sharedPreferences.setString(DEPT_NAME, loginVo.data.deptName);
       sharedPreferences.setString(LAST_SYNC_DATE,'2018-01-01');
       sharedPreferences.setString(LOGIN_API_CALL_DATE,currentdate('yyyy-MM-dd'));
       sharedPreferences.setString(ROUTING_FLAG,loginVo.data.routingFlag);
       sharedPreferences.setString(EMPLOYEE_PROFILE_IMAGE,loginVo.data.profileImage);

  }

}

  String currentdate(String formate) {
    var now = new DateTime.now();
    var formatter = new DateFormat(formate);
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
  }