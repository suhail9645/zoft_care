import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:zoft_care/core/blocs/auth_bloc/auth_bloc.dart';
import 'package:zoft_care/manager/color_manager.dart';
import 'package:zoft_care/manager/font_manager.dart';
import 'package:zoft_care/manager/space_manager.dart';
import 'package:zoft_care/utils/dimensions.dart';
import 'package:zoft_care/widgets/primary_button.dart';

import '../../widgets/primary_text_formfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
 
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(FetchAppVersionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'WELCOME!',
                        style: appFont.f22w600Black,
                      ),
                      appSpaces.spaceForHeight10,
                      Text(
                        'Login',
                        style: appFont.f16w600Black
                            .copyWith(color: appColors.primary),
                      )
                    ],
                  )
                ],
              ),
              Form(
                key: formKey,
                child: Column(
                  children: List.generate(
                    2,
                    (index) {
                      List<String> hints = ['Enter email', 'Enter password'];
                      List<TextEditingController> contrllers = [
                        emailController,
                        passwordController
                      ];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: PrimaryTextFormField(controller: contrllers[index], hint:hints[index],obscure: index==1,),
                      );
                    },
                  ),
                ),
              ),
              appSpaces.spaceForHeight20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is UserSigninSuccessState) {
                          Get.toNamed('/postListScreen');
                        Get.snackbar(
                            'Success', 'Successfully logged to application');
                      
                      } else if (state is UserSigninErrorState) {
                        Get.snackbar('Failed', state.error.message);
                      }
                    },
                    builder: (context, state) {
                      return state is! UserSigninLoadingState
                          ? PrimaryButton(
                              title: 'Login',
                              height: 45,
                              width: screenWidth(context) - 150,
                              radius: 10,
                              titleStyle: appFont.f16w500white,
                              backgroundColor: appColors.primary,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<AuthBloc>(context).add(
                                      UserLoginEvent(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim()));
                                }
                              },
                            )
                          :

                          /// LOADING WIDGET
                          Container(
                              height: 45,
                              width: screenWidth(context) - 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: appColors.primary),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Wait',
                                    style: appFont.f14w600White,
                                  ),
                                  appSpaces.spaceForWidth10,
                                  const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                            );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<AuthBloc, AuthState>(
                    buildWhen: (previous, current) => current is VersionFetchState,
                    builder: (context, state) {
                      if(state is VerstionFetchSuccessState){
                      return Text('Version : ${state.version}');
                      }else{
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
