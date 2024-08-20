part of 'auth_bloc.dart';

abstract class AuthState {}

 class AuthInitial extends AuthState {}

 /// THESE STATES ARE FOR USER SIGNIN
 class UserSigninState extends AuthState{}

 class UserSigninSuccessState extends UserSigninState{}
 
 class UserSigninErrorState extends UserSigninState{
  final ErrorModel error;

  UserSigninErrorState({required this.error});
 }
 
 class UserSigninLoadingState extends UserSigninState{}

 /// THESE STATES ARE FOR VERSION FETCHING
 
 class VersionFetchState extends AuthState{}

 class VerstionFetchSuccessState extends VersionFetchState{
  final String version;

  VerstionFetchSuccessState({required this.version});
 }
 
 class VerstionFetchLoadingState extends VersionFetchState{}
 
 class VerstionFetchErrorState extends VersionFetchState{
  final ErrorModel error;

  VerstionFetchErrorState({required this.error});
 }
