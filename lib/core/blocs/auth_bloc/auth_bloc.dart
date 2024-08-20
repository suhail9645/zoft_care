import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zoft_care/core/models/error_model.dart';
import 'package:zoft_care/core/repo/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo repo;
  AuthBloc(this.repo) : super(AuthInitial()) {
  /// ON USER LOGIN 
      on<UserLoginEvent>((event, emit)async {
      emit(UserSigninLoadingState());
      ErrorModel? error=await repo.userSignin(email: event.email, password: event.password);
      if(error==null){
        emit(UserSigninSuccessState());
      }else{
        emit(UserSigninErrorState(error: error));
      }
    });
    /// ON FETCH APP VERSION
    on<FetchAppVersionEvent>((event, emit)async {
     emit(VerstionFetchLoadingState());
     final response=await repo.getAppVersion();
     if(response.isRight){
      emit(VerstionFetchSuccessState(version: response.right));
     }else{
      emit(VerstionFetchErrorState(error: response.left));
     }
    });
  }
  
}
