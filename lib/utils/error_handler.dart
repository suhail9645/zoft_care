
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoft_care/core/models/error_model.dart';
import 'package:zoft_care/manager/color_manager.dart';
import 'package:zoft_care/manager/font_manager.dart';
import 'package:zoft_care/widgets/primary_button.dart';


ErrorModel errorHandler( Response? response, dynamic error) {
  if (response != null) {
    if (kDebugMode) {
      print('==Error after getting response ${response.body}');
    }
    if (response.statusCode == 400) {
      return ErrorModel(error, 'Bad request');
    }
    /// THE 200 STATUSCODE IS SUCCESS ACTUALLY BUT HERE WE HAVE GETTING THIS AS 'Invalid Credential' ALSO
    else if(response.statusCode==200){
    return ErrorModel(error, 'Invalid Credential');
    }
    else if(response.statusCode==401){
      Get.dialog(
        barrierDismissible: false,
        AlertDialog(
        title:const Text('Token Expired'),
        content:const Text('Your session expired or Invalid token, Please login again'),
        actions: [
          PrimaryButton(
            height: 45,
            backgroundColor: appColors.primary,
            titleStyle: appFont.f16w500white,
            title: 'Login', onTap: ()async {
              SharedPreferences prefs=await SharedPreferences.getInstance();
             await prefs.remove('accessToken');
             await prefs.remove('validity');
            Get.offAllNamed('/');
          },)
        ],
      ));
      return ErrorModel(error, 'Session expired');
    }
    else if(response.statusCode==404){
      return ErrorModel(error,'Not Found' );
    }
    else if(response.statusCode==500){
       return ErrorModel(error,'Something went wrong, please try again' );
    }
     else  {
      return ErrorModel(error, 'Bad request');
    }
  } else {

    /// HERE WE CAN HANDLE APP LEVEL ERROR, TIMEOUT AND MORE
    if (kDebugMode) {
      print('something wrong $error');
    }
    String message='Something went wrong';
    if(error.message!=null&& error.message=='Future not completed'){
      message='RequestTimeout, try again';
    }
    return ErrorModel(error.toString(), message);
  }
}
