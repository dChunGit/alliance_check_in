import 'package:flutter/material.dart';

class SlideRightTransition extends PageRouteBuilder {
  final Widget page;

  SlideRightTransition({this.page}): super(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page,
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child
        );
      });
}

class SlideLeftTransition extends PageRouteBuilder {
  final Widget page;

  SlideLeftTransition({this.page}): super(
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page,
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child
        );
      });
}

class MultiPurposeRoute extends PageRouteBuilder {
  final Widget enterPage;
  final Widget exitPage;
  MultiPurposeRoute({this.exitPage, this.enterPage})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) => enterPage,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) => Stack(
      children: <Widget>[
        SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(0.0, 0.0),
            end: const Offset(-1.0, 0.0),
          ).animate(animation),
          child: exitPage,
        ),
        SlideTransition(
          position: new Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: enterPage,
        )
      ],
    ),
  );
}