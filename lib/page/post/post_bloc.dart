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
    if (event is Login){
      yield PostLoading();
      try {
        final LoginResponse response = await repository.login();
        yield LoginLoaded(response: response);
      } catch (e) {
        print("AAA The value is $e");
        yield PostError();
      }
    }else if (event is Profile){
      yield PostLoading();
      try {
        final ProfileResponse profile = await repository.getProfile();
        yield ProfileLoaded(profile: profile);
      } catch (e) {
        print("AAA The value is $e");
        yield PostError();
      }
    }else if (event is FetchPost){
      yield PostLoading();
      try {
        final PostResponse profile = await repository.getPost(postType: 0, limit: 0);
        yield PostLoaded(post: profile);
      } catch (e) {
        print("AAA The value is $e");
        yield PostError();
      }
    }
  }
}