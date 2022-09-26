import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/constracts.dart';
import 'package:quiz_u/providers/auth.dart';

class OtpCode extends StatefulWidget {
  const OtpCode({Key? key}) : super(key: key);

  @override
  State<OtpCode> createState() => _OtpCodeState();
}

class _OtpCodeState extends State<OtpCode> {
  @override
  Widget build(BuildContext context) {
    final otp = Provider.of<OtpClass>(context);

    return Pinput(
      length: 4,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      validator: (pin) {
        if (pin == '0000') {
          otp.changeValid();
          otp.updateOtpCode(pin);
          return null;
        } else {
          otp.setToFalse();
          return 'Pin is incorrect';
        }
      },
      defaultPinTheme: PinTheme(
        textStyle: const TextStyle(
          color: blueColor,
          fontSize: 23,
          fontWeight: FontWeight.w600,
        ),
        width: 43,
        height: 52,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: boxshadow
        ),
      ),
    );
  }
}
