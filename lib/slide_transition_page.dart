import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

typedef TransitionBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
);

class SlideTransitionPage extends CustomTransitionPage {
  const SlideTransitionPage({required super.child, super.key}) : super(transitionsBuilder: _slideTransitionBuild);

  static Widget _slideTransitionBuild(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child
  ) {
    return SlideTransition(
      position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation),
      child: child,
    );
  }
}