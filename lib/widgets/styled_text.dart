import 'package:flutter/material.dart';

import '../constracts.dart';

class CustomText extends StatelessWidget {
  final String data;
  final double size;
  final Color color;
  final FontWeight weight;
  final TextAlign align;

  const CustomText({
    Key? key,
    required this.data,
    this.size = 20.0,
    this.color = whiteColor,
    this.weight = FontWeight.w400,
    this.align = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: align,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }
}

class QuizLogo extends StatelessWidget {
  const QuizLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CustomText(data: 'Q', weight: FontWeight.w500, color:blueColor, size: 25),
        CustomText(data: 'uiz', weight: FontWeight.w500, color: blackColor, size:25),
        CustomText(data: 'U', weight: FontWeight.w500, color: orangeColor, size:25),
        CustomText(data: ' App', weight: FontWeight.w500, color: orangeColor, size:25),
      ],
    );
  }
}
