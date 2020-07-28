import 'package:iot_kminh/model/response/login_response.dart';
import 'package:iot_kminh/model/response/profile_response.dart';
import 'package:iot_kminh/model/users.dart';
import 'package:iot_kminh/network/repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final Repository repository;
  PostBloc({@required this.repository}) : super(QuoteEmpty());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async*{
    if (event is FetchQuote) {
      yield QuoteLoading();
      try {
        final Users quote = await repository.fetchQuote();
        yield QuoteLoaded(quote: quote);
      } catch (e) {
        print("AAA The value is $e");
        yield QuoteError();
      }
    } else if (event is Login){
      yield QuoteLoading();
      try {
        final LoginResponse response = await repository.login();
        yield LoginLoaded(response: response);
      } catch (e) {
        print("AAA The value is $e");
        yield QuoteError();
      }
    }else if (event is Profile){
      yield QuoteLoading();
      try {
        final ProfileResponse profile = await repository.getProfile();
        yield ProfileLoaded(profile: profile);
      } catch (e) {
        print("AAA The value is $e");
        yield QuoteError();
      }
    }
  }
}