part of 'post_bloc.dart';

abstract class PostState {}

 class PostInitial extends PostState {}

 /// THIS STATES ARE FOR FETCHING POST
class PostFetchState extends PostState{}

class PostFetchSuccessState extends PostFetchState{
  final List<PostModel> allPosts;
  final bool isLoading;
  PostFetchSuccessState({required this.allPosts,required this.isLoading});
}

class PostFetchErrorState extends PostFetchState{
  final ErrorModel error;

  PostFetchErrorState({required this.error});
}
  class PostFetchLoadingState extends PostFetchState{
    
  }
