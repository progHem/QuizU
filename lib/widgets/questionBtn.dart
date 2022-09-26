// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:quiz_u/widgets/styled_text.dart';

import '../constracts.dart';

class QuestionBtn extends StatefulWidget {
  Function onPress;
  String data;

  QuestionBtn({
    Key? key,
    required this.data,
    required this.onPress,
  }) : super(key: key);

  @override
  State<QuestionBtn> createState() => _QuestionBtnState();
}

class _QuestionBtnState extends State<QuestionBtn> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () {
          widget.onPress();
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(3.0),
          backgroundColor: MaterialStateProperty.all(whiteColor),
          padding: MaterialStateProperty.all(
              const EdgeInsets.only(top: 11.0, bottom: 11.0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          ),
          side: MaterialStateProperty.all(
            const BorderSide(
                color: shadow,
                width: 1),
          ),
        ),
        child: Center(
            child:
                CustomText(data: widget.data, color: blackColor, size: 17.5)));
  }
}
