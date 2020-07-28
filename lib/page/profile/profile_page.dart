import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key, this.animationController}) : super(key: key);

  final AnimationController animationController;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> with TickerProviderStateMixin {
  Animation<double> topBarAnimation;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Profile Page",
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),
    );
  }
}