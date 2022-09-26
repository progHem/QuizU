import 'package:flutter/material.dart';

import '../constracts.dart';

class StyledBox extends StatelessWidget {
  final double width;
  final double height;
  final Color fColor;
  final Color lColor;
  final Widget child;

  const StyledBox({Key? key, required this.width, required this.height, this.fColor= blueColor, this.lColor= const Color.fromRGBO(79, 120, 238, 1), required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        boxShadow: boxshadow,
        borderRadius: BorderRadius.circular(12.5),
        gradient: LinearGradient(
          begin: const Alignment(-0.9, -0.0),
          end: const Alignment(0.0, -0.0),
          colors: [fColor, lColor],
        ),
      ),
      child: child
    );
  }
}