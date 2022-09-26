// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../constracts.dart';
import 'styled_text.dart';

class StartBtn extends StatelessWidget {
  final Function onPress;
  final String data;
  final bool isValid;
  const StartBtn({Key? key, required this.onPress, required this.data, required this.isValid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final disableColor = MaterialStateProperty.all(grayColor);
    final enableColor = MaterialStateProperty.all(orangeColor);
    return ElevatedButton(
        onPressed: isValid
            ? () {
                onPress();
              }
            : null,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          backgroundColor: isValid ? enableColor : disableColor,
          padding: MaterialStateProperty.all(
              const EdgeInsets.only(top: 13.0, bottom: 13.0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          ),
        ),
        child: CustomText(data: data));
  }
}


class StyledBtn extends StatelessWidget {
  final Function onPress;
  final String data;
  Color ?color;
  double ?cirular;

  StyledBtn(
      {Key? key,
      required this.onPress,
      required this.data,
      this.color,
      this.cirular
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed:  () {
                onPress();
              },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.0),
          backgroundColor: MaterialStateProperty.all(color ?? orangeColor),
          padding: MaterialStateProperty.all(
              const EdgeInsets.only(top: 13.0, bottom: 13.0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(cirular ?? 6.0)),
          ),
        ),
        child: CustomText(data: data));
  }
}
