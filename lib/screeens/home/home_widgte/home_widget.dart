import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/widgets/styled_btn.dart';

import '../../../constracts.dart';
import '../../../providers/questions.dart';
import '../../../widgets/styled_text.dart';
import '../../questions/question_widget.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final question = Provider.of<QuestionInfo>(context);

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
                SizedBox(height: height * 0.07),
                const QuizLogo(),
                SizedBox(height: height * 0.03),
                 SizedBox(
                   width: width,
                   height: height * 0.30,
                   child: SvgPicture.asset(
                     'assets/images/home.svg',
                   ),
                 ),
                 SizedBox(height: height * 0.04),
                 const CustomText(
                     data: 'Ready to test your knoweldge and challenge others?',
                     color: blueColor,
                     weight: FontWeight.w700,
                     size: 20.0,
                     align: TextAlign.center),
                SizedBox(height: height * 0.04),
                Column(
                  children: [
                    SizedBox(
                      width: width*0.50,
                      child: StyledBtn(
                        data: 'Quiz Me!',
                        onPress: () {
                       
                        question.reset();
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Question()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.03),
                const CustomText(
                    data:
                        'Answer as much questions correctly within 2 minutes',
                    size: 15.5,
                    color: blackColor,
                    align: TextAlign.center),
                // Visibility(
                //     visible: _isLoaded,
                //     child: const CircularProgressIndicator(
                //       color: blueColor,
                //     )),
               
              ],
            ),
          ),
        ),
      )
      ),
    );
  }
}
