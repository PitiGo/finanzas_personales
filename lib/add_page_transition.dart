import 'package:flutter/material.dart';

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  final Widget background;
  SlideRightRoute({this.background, this.widget})
      : super(
            transitionDuration: Duration(microseconds: 1),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return Stack(
                children: <Widget>[
                  background,
                  widget,
                ],
              );
            });
}

// SlideTransition(
//             position: new Tween<Offset>(
//               begin: const Offset(-1.0, 0.0),
//               end: Offset.zero,
//             ).animate(animation),
//             child: child,
//            );
