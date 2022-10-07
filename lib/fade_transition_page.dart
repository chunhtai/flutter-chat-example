import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget _fadeTransitionBuild(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child
) {
  return FadeTransition(
    opacity: animation,
    child: child,
  );
}

class FadeTransitionPage extends CustomTransitionPage {
  const FadeTransitionPage({required super.child, super.key}) : super(transitionsBuilder: _fadeTransitionBuild);
}