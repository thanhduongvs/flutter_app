import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchPage> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Search Page",
          style: TextStyle(
              color: Colors.black
          ),
        ),
      ),
    );
  }
}