import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoft_care/core/blocs/post_bloc/post_bloc.dart';
import 'package:zoft_care/core/models/post_model.dart';
import 'package:zoft_care/manager/font_manager.dart';
import 'package:zoft_care/manager/space_manager.dart';


class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  int count = 10;
  int page = 1;
  List<PostModel> allPosts = [];
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    
    super.initState();
    BlocProvider.of<PostBloc>(context).add(
        PostFetchEvent(count: count, page: page, allReadyFetched: allPosts));
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          BlocProvider.of<PostBloc>(context).add(PostFetchEvent(
              count: count, page: ++page, allReadyFetched: allPosts));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          appSpaces.spaceForHeight30,
          Text(
            'Posts',
            style: appFont.f18w1000Black,
          ),
          Expanded(
            child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
              if (state is PostFetchSuccessState) {
               allPosts=state.allPosts;
                return ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      
                      PostModel postModel=state.allPosts[index!=state.allPosts.length?index:0];
                      return index != state.allPosts.length
                          ? Container(
                              height: 270,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 180,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10)),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                'https://images.pexels.com/photos/307008/pexels-photo-307008.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          postModel.title.toString(),
                                          maxLines: 1,
                                          style: appFont.f16w600Black,
                                           overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                         postModel.body.toString(),
                                         maxLines: 2,
                                          style: appFont.f14w400Black,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          : state.isLoading
                              ? const SizedBox(
                                  height: 40,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const SizedBox();
                    },
                    separatorBuilder: (context, index) =>
                        appSpaces.spaceForHeight15,
                    itemCount: (state.allPosts.length+1));
              } else if (state is PostFetchErrorState) {
                return Center(
                  child: Text(
                    state.error.message,
                    style: appFont.f16w500Black,
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          )
        ],
      ),
    ));
  }
}
