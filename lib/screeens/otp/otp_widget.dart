// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/constracts.dart';
import 'package:quiz_u/providers/auth.dart';
import 'package:quiz_u/screeens/otp/otp_code_widget.dart';
import 'package:quiz_u/screeens/userName/username.dart';
import 'package:quiz_u/widgets/styled_btn.dart';
import 'package:quiz_u/widgets/styled_text.dart';
import 'package:http/http.dart' as http;

import '../../sharedPrefernce/shared_preference.dart';

class Otp extends StatefulWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  bool _isLoaded = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final otp = Provider.of<OtpClass>(context);
    final isValid = otp.isValid;

    final phone = Provider.of<Phone>(context);

    postData() async {
      setState(() {
        _isLoaded = true;
      });
      var url = Uri.parse('https://quizu.okoul.com/Login');
      var response = await http
          .post(url, body: {'OTP': otp.otpCode, 'mobile': phone.phone});

      var jsonresponse = jsonDecode(response.body);

      saveToPref(jsonresponse['token'], 'token');

      setState(() {
        _isLoaded = false;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.05),
                  const Expanded(flex: 1, child: QuizLogo()),
                  //SizedBox(height: height * 0.05),
                  const Expanded(
                    flex: 1,
                    child: CustomText(
                        data: 'Please enter the Test sent to your mobile:',
                        color: grayColor,
                        size: 18.0,
                        align: TextAlign.center),
                  ),
                  //  SizedBox(height: height * 0.03),
                  const Expanded(flex: 1, child: OtpCode()),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        SizedBox(height: height * 0.03),
                        SizedBox(
                          width: width,
                          child: StartBtn(
                            isValid: isValid,
                            data: 'Check',
                            onPress: () async {
                              await postData();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Username()), // second screen widget
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: _isLoaded,
                      child: const CircularProgressIndicator(
                        color: blueColor,
                      )),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: width,
                      child: SvgPicture.asset(
                        'assets/images/clipart-Otp.svg',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
