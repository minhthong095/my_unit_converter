import 'package:flutter/cupertino.dart';

class TransitionBotTop extends PageRouteBuilder {
  final Widget child;
  TransitionBotTop({@required this.child})
      : super(
            transitionDuration: Duration(milliseconds: 800),
            pageBuilder: (context, animation, secondAnimation) => child,
            transitionsBuilder: (context, animation, secondAnimation, child) {
              final begin = Offset(0.0, 1.0);
              final end = Offset(0, 0);
              final tween = Tween(begin: begin, end: end)
                  .chain(CurveTween(curve: Curves.easeInOutQuart));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            });
}
