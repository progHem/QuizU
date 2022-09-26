import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/screeens/questions/wrong.dart';
import 'package:quiz_u/widgets/questionBtn.dart';
import 'package:quiz_u/widgets/styled_btn.dart';
import 'package:quiz_u/widgets/styled_text.dart';

import '../../constracts.dart';
import '../../providers/questions.dart';
import '../../sharedPrefernce/shared_preference.dart';
import '../home/timer/timer.dart';
import 'completed.dart';
import 'package:http/http.dart' as http;

class Question extends StatefulWidget {
  const Question({Key? key}) : super(key: key);

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  List questions = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  Future getQuestions() async {
    setState(() {
      isLoading = true;
    });
    var token = await getFromPref('token');

    var url = Uri.parse('https://quizu.okoul.com/Questions');
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});

    var jsonresponse = jsonDecode(response.body);

    setState(() {
      questions = jsonresponse;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = Provider.of<QuestionInfo>(context);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    int currentQuestion = question.current;
    int score = question.score;

    checkAnswer(answer) {
      if (answer == questions[currentQuestion]['correct']) {
        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: height, minWidth: width),
            child: SingleChildScrollView(
                child: isLoading
                    ? Padding(
                        padding: EdgeInsets.only(top: height * 0.50),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: blueColor,
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            SizedBox(height: height * 0.05),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomText(
                                    data: 'Score $score',
                                    color: orangeColor,
                                    size: 23.5),
                              ],
                            ),
                            SizedBox(height: height * 0.04),
                            const Timer(),
                            SizedBox(height: height * 0.04),
                            SizedBox(
                              width: width,
                              child: Column(
                                children: [
                                  CustomText(
                                     size: 22.0,
                                      data: 'Question${currentQuestion + 1}',
                                      color: blueColor,
                                      weight: FontWeight.w700),
                                  CustomText(
                                      align: TextAlign.center,
                                      data:
                                          '${questions[currentQuestion]['Question']}',
                                      color: blackColor),
                                  SizedBox(height: height * 0.03),
                                  QuestionBtn(
                                    data: '${questions[currentQuestion]['a']}',
                                    onPress: () {
                                      if (checkAnswer('a') == true) {
                                        question.updateCurrent();
                                        question.updateScore();
                                        if (currentQuestion == 29) {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                       Completed(score: question.score,)));
                                       //   question.reset();
                                        }
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Wrong()),
                                        );
                                        question.reset();
                                      }
                                    },
                                  ),
                                  SizedBox(height: height * 0.02),
                                  QuestionBtn(
                                    data: '${questions[currentQuestion]['b']}',
                                    onPress: () {
                                      if (checkAnswer('b') == true) {
                                        question.updateCurrent();
                                        question.updateScore();
                                        if (currentQuestion == 29) {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                       Completed(score: question.score)));
                                         // question.reset();
                                        }
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Wrong()),
                                        );
                                        question.reset();
                                      }
                                    },
                                  ),
                                  SizedBox(height: height * 0.02),
                                  QuestionBtn(
                                    data: '${questions[currentQuestion]['c']}',
                                    onPress: () {
                                      if (checkAnswer('c') == true) {
                                        question.updateCurrent();
                                        question.updateScore();
                                        if (currentQuestion == 29) {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                       Completed(score: question.score)));
                                        //  question.reset();
                                        }
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Wrong()),
                                        );
                                        question.reset();
                                      }
                                    },
                                  ),
                                  SizedBox(height: height * 0.02),
                                  QuestionBtn(
                                    data: '${questions[currentQuestion]['d']}',
                                    onPress: () {
                                      if (checkAnswer('d') == true) {
                                        question.updateCurrent();
                                        question.updateScore();
                                        if (currentQuestion == 29) {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                       Completed(score: question.score)));
                                         // question.reset();
                                        }
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Wrong()),
                                        );
                                        question.reset();
                                      }
                                    },
                                  ),
                                  SizedBox(height: height * 0.05),
                                  SizedBox(
                                      width: width * 0.50,
                                      child: StyledBtn(
                                          onPress: () {
                                            if (question.canSkip == true) {
                                              question.updateSkip();
                                              question.updateCurrent();
                                            }
                                          },
                                          data: 'Skip',
                                          color: question.canSkip
                                              ? blueColor
                                              : grayColor))
                                ],
                              ),
                            )
                          ])),
          ),
        ),
      ),
    );
  }
}
