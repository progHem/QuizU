// ignore_for_file: must_be_immutable, unused_local_variable, unnecessary_brace_in_string_interps, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/constracts.dart';
import 'package:quiz_u/screeens/home/home.dart';
import 'package:quiz_u/widgets/styled_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../providers/questions.dart';
import '../../sharedPrefernce/shared_preference.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Completed extends StatefulWidget {
  final int score;
  bool isLoading = true;

  Completed({Key? key, required this.score}) : super(key: key);

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
    @override
  void initState() {
    super.initState();
    postScore();
  }

  Future postScore() async {
    var token = await getFromPref('token');

    var url = Uri.parse('https://quizu.okoul.com/Score');
    
    var response = await http.post(url,
        headers: {"Authorization": "Bearer $token"},
        body: {"score": "${widget.score}"});

    var jsonresponse = jsonDecode(response.body);
    setState(() {
      widget.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = Provider.of<QuestionInfo>(context);

    String date = DateFormat("yyyy/MM/dd").format(DateTime.now());
    String time = DateFormat('hh:mm a').format(DateTime.now());

    var jsonData = {"score": question.score, "date": date, "time": time, "datetime":'${date} ${time}'};

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                final savedList = prefs.getStringList('scores');
                if (savedList == null) {
                  saveScoreList();
                  appendToPref(json.encode(jsonData));
                } else {
                  appendToPref(json.encode(jsonData));
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
              icon: const Icon(Icons.cancel, color: blackColor, size: 35))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: height, minWidth: width),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.06),
                    SizedBox(
                      width: width,
                      height: height * 0.30,
                      child: SvgPicture.asset(
                        'assets/images/win.svg',
                      ),
                    ),
                    SizedBox(height: height * 0.06),
                    const CustomText(
                        data: 'You have completed',
                        color: blackColor,
                        size: 25.5),
                    CustomText(
                      data: '${question.score}',
                      color: blackColor,
                      size: 40,
                      weight: FontWeight.w700,
                    ),
                    const CustomText(
                        data: 'correct answers!',
                        color: blackColor,
                        size: 24.5),
                    SizedBox(height: height * 0.02),
                    TextButton(
                        onPressed: () async {
                          await Share.share(
                              'I answered ${question.score} correct answers in QuizU!');
                        },
                        child: SizedBox(
                          width: width * 0.30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Expanded(
                                  child: Icon(
                                Icons.share,
                                size: 28,
                                color: orangeColor,
                              )),
                              // SizedBox(height: width * 0.001),
                              Expanded(
                                  child: CustomText(
                                      data: 'Share', color: orangeColor)),
                            ],
                          ),
                        ))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
