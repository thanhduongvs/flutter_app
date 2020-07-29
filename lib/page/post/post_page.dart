import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'post_bloc.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<PostPage> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostInitial) {
          //BlocProvider.of<PostBloc>(context).add(FetchQuote());
          //context.bloc<PostBloc>().add(FetchQuote());
          context.bloc<PostBloc>().add(FetchPost());
          //context.bloc<PostBloc>().add(Profile());
        }
        if (state is PostError) {
          return Center(
            child: Text('failed to fetch quote'),
          );
        }
        if (state is LoginLoaded) {
          return ListTile(
            leading: Text(
              '${state.response.message}',
              style: TextStyle(fontSize: 10.0),
            ),
            title: Text(state.response.data.account),
            isThreeLine: true,
            subtitle: Text(state.response.data.userName),
            dense: true,
          );
        }
        return Center(
          //child: CircularProgressIndicator(),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                leading: Text('$index'),
                title: Text('Hello'),
                isThreeLine: true,
                subtitle: Text('hahah'),
              );
            }
          ),
        );
      },
    );
  }
}