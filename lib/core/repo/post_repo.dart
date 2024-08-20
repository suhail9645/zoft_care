import 'dart:convert';

import 'package:http/http.dart';
import 'package:zoft_care/core/models/error_model.dart';
import 'package:zoft_care/core/models/post_model.dart';
import 'package:either_dart/either.dart';
import 'package:zoft_care/manager/url_manager.dart';
import 'package:zoft_care/utils/error_handler.dart';
class PostRepo{
  Future<Either<ErrorModel,List<PostModel>>> getPosts({required int page,required int count})async{
     try {
       final response=await get(Uri.parse('$baseUrl/posts?page=$page&size=$count'),headers: {
        "x-auth-key":accessToken
       }).timeout(const Duration(seconds: 8));
       if(response.statusCode==200){
        List<PostModel>allPosts=PostModel.fromList(jsonDecode(response.body)['data']);
        return Right(allPosts);
       }
       else{
        return Left(errorHandler(response, null));
       }
     } catch (e) {
       return Left(errorHandler(null, e));
     }
  }
}