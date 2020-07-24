import 'package:flutter/material.dart';

class Button extends StatefulWidget{
  final Widget defaultWidget;
  final Widget progressWidget;
  final Function onPressed;
  final ButtonType type;
  final Color color;
  final double width;
  final double height;
  final double radius;

  Button({
    Key key,
    this.defaultWidget,
    this.progressWidget,
    this.onPressed,
    this.type = ButtonType.Contained,
    this.color,
    this.width = double.infinity,
    this.height = 40.0,
    this.radius = 4.0,
  }) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button>
    with TickerProviderStateMixin {

  GlobalKey _globalKey = GlobalKey();
  Animation _anim;
  AnimationController _animController;
  Duration _duration = const Duration(milliseconds: 250);
  ButtonState _state;
  double _width;
  double _height;
  double _borderRadius;

  void _reset() {
    _state = ButtonState.Default;
    _width = widget.width;
    _height = widget.height;
    _borderRadius = widget.radius;
  }

  @override
  dispose() {
    _animController?.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _reset();
    super.deactivate();
  }

  @override
  void initState() {
    _reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: SizedBox(
        key: _globalKey,
        height: _height,
        width: _width,
        child: _buildChild(context),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    var padding = const EdgeInsets.all(0.0);
    var color = widget.color;
    var shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_borderRadius));

    switch (widget.type) {
      case ButtonType.Contained:
        return RaisedButton(
          padding: padding,
          color: color,
          shape: shape,
          child: _buildChildren(context),
          onPressed: _onButtonPressed(),
        );
      case ButtonType.Text:
        return FlatButton(
          padding: padding,
          color: color,
          shape: shape,
          child: _buildChildren(context),
          onPressed: _onButtonPressed(),
        );
      case ButtonType.Outline:
        return OutlineButton(
          padding: padding,
          color: color,
          shape: shape,
          child: _buildChildren(context),
          onPressed: _onButtonPressed(),
        );
    }
  }

  Widget _buildChildren(BuildContext context) {
    Widget ret;
    switch (_state) {
      case ButtonState.Default:
        ret = widget.defaultWidget;
        break;
      case ButtonState.Processing:
        ret = widget.progressWidget ?? widget.defaultWidget;
        break;
    }
    return ret;
  }

  VoidCallback _onButtonPressed() {
    return widget.onPressed == null
        ? null
        : () async {
      if (_state != ButtonState.Default) {
        return;
      }

      // The result of widget.onPressed() will be called as VoidCallback after button status is back to default.
      VoidCallback onDefault;

    };
  }

  void _toProcessing() {
    setState(() {
      _state = ButtonState.Processing;
    });
  }

  void _toDefault() {
    if (mounted) {
      setState(() {
        _state = ButtonState.Default;
      });
    } else {
      _state = ButtonState.Default;
    }
  }

  void _forward(AnimationStatusListener stateListener) {
    double initialWidth = _globalKey.currentContext.size.width;
    double initialBorderRadius = widget.radius;
    double targetWidth = _height;
    double targetBorderRadius = _height / 2;

    _animController = AnimationController(duration: _duration, vsync: this);
    _anim = Tween(begin: 0.0, end: 1.0).animate(_animController)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - targetWidth) * _anim.value);
          _borderRadius = initialBorderRadius -
              ((initialBorderRadius - targetBorderRadius) * _anim.value);
        });
      })
      ..addStatusListener(stateListener);

    _animController.forward();
  }

  void _reverse() {
    _animController.reverse();
  }
}

enum ButtonState {
  Default,
  Processing,
}

enum ButtonType {
  Text,
  Contained,
  Toggle,
  Outline,
  Icon
}