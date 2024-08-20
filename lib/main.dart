import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoft_care/core/blocs/auth_bloc/auth_bloc.dart';
import 'package:zoft_care/core/blocs/post_bloc/post_bloc.dart';
import 'package:zoft_care/core/repo/auth_repo.dart';
import 'package:zoft_care/core/repo/post_repo.dart';
import 'package:zoft_care/manager/route_manager.dart';
import 'package:zoft_care/manager/url_manager.dart';
import 'package:zoft_care/presentation/login_screen/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoft_care/utils/error_handler.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  bool isUserAlreadyLogin=await isAlreadyLogin();
  runApp( ZoftCare(isUserAlreadyLogin: isUserAlreadyLogin,));
}

class ZoftCare extends StatelessWidget {
  const ZoftCare({super.key, required this.isUserAlreadyLogin});
final bool isUserAlreadyLogin;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepo(),),
        RepositoryProvider(create: (context) => PostRepo(),)
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepo>()),
          ),
          BlocProvider(create: (context) => PostBloc(context.read<PostRepo>()),)
        ],
        child: GetMaterialApp(
          title: 'ZoftCare',
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute:isUserAlreadyLogin?'postListScreen': '/',
          getPages: getPages(),
        ),
      ),
    );
  }
}

/// THIS FUNCTION CHECKING THE USER ALREADY LOGIN OR NOT IF LOGIN ASSIGN THE TOKEN LOCALLY
Future<bool>isAlreadyLogin()async{
  try {
final SharedPreferences prefs = await SharedPreferences.getInstance();
 String ?token=prefs.getString('accessToken');
 accessToken=token??'';
 return token!=null;

  } catch (e) {
    errorHandler(null, e);
    return false;
  }
}