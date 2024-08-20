
import 'package:get/get.dart';
import 'package:zoft_care/presentation/login_screen/login_screen.dart';
import 'package:zoft_care/presentation/post_list_screen/post_list_screen.dart';

/// IN APP WE USING NAMED ROUTING , SO SCREEN WE WILL SPECIFY HERE WITH A NAME.
List<GetPage>getPages(){
  return [
     GetPage(name: '/', page: () =>const LoginScreen(),),
     GetPage(name: '/postListScreen', page: () =>const PostListScreen(),)
  ];
}