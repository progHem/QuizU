// ignore_for_file: use_build_context_synchronously

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/constracts.dart';
import 'package:quiz_u/widgets/styled_btn.dart';
import 'package:quiz_u/widgets/styled_text.dart';

import '../../providers/auth.dart';
import '../../sharedPrefernce/shared_preference.dart';
import '../../widgets/styled_text_field.dart';
import '../home/home.dart';

class Username extends StatefulWidget {
  const Username({Key? key}) : super(key: key);

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  @override
  Widget build(BuildContext context) {
    bool isLoaded = false;

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final user = Provider.of<User>(context);

    postName(name) async {
      setState(() {
        isLoaded = true;
      });
      var token = await getFromPref('token');

      var url = Uri.parse('https://quizu.okoul.com/Name');
      var response = await http.post(url,
          body: {'name': name}, headers: {"Authorization": "Bearer $token"});

      if (response.body.isNotEmpty) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
      }

      setState(() {
        isLoaded = false;
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
                  SizedBox(height: height * 0.05),
                  const Expanded(
                    flex: 1,
                    child: CustomText(
                        data: 'What is Your Name?',
                        color: blackColor,
                        align: TextAlign.center),
                  ),
                  const Expanded(flex: 1, child: StyledField()),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        SizedBox(
                          width: width,
                          child: StyledBtn(
                            data: 'Done',
                            onPress: () async {
                              if (user.username.isEmpty) {
                                user.changeValid();
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      title: CustomText(
                                          data:
                                              'Please write you name on this field',
                                          size: 18,
                                          color: blackColor),
                                    );
                                  },
                                );
                              } else {
                                user.setToFalse();
                                user.username = user.username;
                                await postName(user.username);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: isLoaded,
                      child: const CircularProgressIndicator(
                        color: blueColor,
                      )),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: width,
                      child: SvgPicture.asset(
                        'assets/images/clipart-Otp.svg',
                        // width: 200,
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
