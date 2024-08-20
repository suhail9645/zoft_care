import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zoft_care/core/models/error_model.dart';
import 'package:zoft_care/core/models/post_model.dart';
import 'package:zoft_care/core/repo/post_repo.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepo repo;
  PostBloc(this.repo) : super(PostInitial()) {
    /// ON FETCH APP POSTS
    on<PostFetchEvent>((event, emit)async {
      if(event.allReadyFetched.isEmpty){
      emit(PostFetchLoadingState());
      }else{
        emit(PostFetchSuccessState(allPosts: event.allReadyFetched, isLoading: true));
      }
      final response=await repo.getPosts(page: event.page, count: event.count);
      if(response.isRight){
        
        emit(PostFetchSuccessState(allPosts: [...event.allReadyFetched,...response.right],isLoading: false));
      }else{
        emit(PostFetchErrorState(error: response.left));
      }
    });
  }
}
