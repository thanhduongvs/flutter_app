import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapPage> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("MapPage",
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
    );
  }
}