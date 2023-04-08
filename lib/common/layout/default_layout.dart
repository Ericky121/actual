import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroudColor;
  final Widget child;

  const DefaultLayout({Key? key, required this.child, this.backgroudColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroudColor ?? Colors.white,
      body: child,
    );
  }
}
