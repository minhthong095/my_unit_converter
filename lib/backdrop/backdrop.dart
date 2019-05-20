import 'package:flutter/material.dart';

class Backdrop extends StatefulWidget {
  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  final Tween<double> animation = Tween(begin: 0, end: 1);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        value: 0, vsync: this, duration: Duration(seconds: 1));

    animation.animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: _toggleAppBarBtn,
            icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: animation.animate(_controller),
            )),
        title: Text("Aventer"),
      ),
      body: Container(
        color: Colors.red,
      ),
    );
  }

  void _toggleAppBarBtn() {
    print("Controller status " + _controller.status.toString());
    if (_controller.status == AnimationStatus.dismissed) // at begining
      _controller.animateTo(1);
    else
      _controller.animateBack(0);
  }
}
