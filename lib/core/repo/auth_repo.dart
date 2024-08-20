import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart';
import 'package:zoft_care/core/models/error_model.dart';
import 'package:zoft_care/manager/url_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoft_care/utils/error_handler.dart';
class AuthRepo{

  /// USER SIGN IN FUNCTION
  Future<ErrorModel?>userSignin({required String email,required String password})async{

    try {
      final response=await post(Uri.parse('https://mock-api.zoft.care/login'),body: {
        'email':email,
        'password':password
      }).timeout(const Duration(seconds: 8));
      if(response.statusCode==200&&jsonDecode(response.body)['status']){
        /// HERE WE CAN STORE ANY NECCESSARY DATA TO STORAGE
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String token=json.decode(response.body)['data']['accessToken'];
        accessToken=token;
        /// FINDING THE EXPIRATION TIME AND STORING IT
        String ? validity=json.decode(response.body)['validity'];
        DateTime validityTime=DateTime.now().add(Duration(milliseconds: int.parse(validity??'60000')));
        /// STORING TOKEN AND VALIDITY TIME
        prefs.setString('accessToken', token);
        prefs.setString('validity', validityTime.toString());
        return null;
      }
      else{
         return errorHandler(response, null);
      }
    } catch (e) {
      return errorHandler(null,e);
    }
    
  }

  /// GET APP VERSION FUNCTION
  Future<Either<ErrorModel,String>>getAppVersion()async{
    try {
      final response=await get(Uri.parse('$baseUrl/version')).timeout(const Duration(seconds: 8));
      if(response.statusCode==200){
        String version=jsonDecode(response.body)['data']['version'];
        return Right(version);
      }
      else{
        return Left(errorHandler(response, null));
      }
    } catch (e) {
      return Left(errorHandler(null, e));
    }
  }
}