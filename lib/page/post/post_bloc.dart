import 'package:iot_kminh/model/response/login_response.dart';
import 'package:iot_kminh/model/response/post_response.dart';
import 'package:iot_kminh/model/response/profile_response.dart';
import 'package:iot_kminh/network/repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final Repository repository;
  PostBloc({@required this.repository}) : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final currentState = state;
    if (event is Login){
      yield PostLoading();
      try {
        final LoginResponse response = await repository.login();
        yield LoginLoaded(response: response);
      } catch (e) {
        print("AAA The value is $e");
        yield PostFailure();
      }
    }else if (event is Profile){
      yield PostLoading();
      try {
        final ProfileResponse profile = await repository.getProfile();
        yield ProfileLoaded(profile: profile);
      } catch (e) {
        print("AAA The value is $e");
        yield PostFailure();
      }
    } else if (event is PostFetched && !_hasReachedMax(currentState)) {
      print("DEBUG: PostFetched");
      yield PostLoading();
      try {
        if (currentState is PostInitial) {
          final PostResponse response = await repository.getPost(postType: 0, limit: 0);
          yield PostSuccess(posts: response.data.posts, hasReachedMax: false);
          //return;
        }
        if (currentState is PostSuccess) {
          final PostResponse response = await repository.getPost(postType: 0, limit: currentState.posts.length);
          final posts = response.data.posts;
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostSuccess(
            posts: currentState.posts + posts,
            hasReachedMax: false,
          );
        }
      } catch (e) {
        print("Post Error: $e");
        yield PostFailure();
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostSuccess && state.hasReachedMax;


}