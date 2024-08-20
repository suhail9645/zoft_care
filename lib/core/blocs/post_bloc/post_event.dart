part of 'post_bloc.dart';

abstract class PostEvent {}
/// THIS EVENT FOR FETCHING ALL POSTS
class PostFetchEvent extends PostEvent{
  final int count;
  final int page;
  final List<PostModel> allReadyFetched;
  PostFetchEvent({required this.count, required this.page,required this.allReadyFetched});
}
