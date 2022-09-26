import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../providers/auth.dart';
import '../../widgets/styled_btn.dart';
import '../otp/otp_widget.dart';
import 'phone_input/phone_input_widgte.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final phone = Provider.of<Phone>(context);
    final isValid = phone.isValid;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height * 0.07),
              SizedBox(
                width: width,
                height: height * 0.35,
                //color:Colors.amber,
                child: SvgPicture.asset(
                  'assets/images/start.svg',
                  width: 200,
                ),
              ),
              SizedBox(height: height * 0.07),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Column(
                  children: [
                    const PhoneInput(),
                    SizedBox(height: height * 0.05),
                    SizedBox(
                      width: width,
                      child: StartBtn(
                        data: 'Start',
                        isValid: isValid,
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Otp()), // second screen widget
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
