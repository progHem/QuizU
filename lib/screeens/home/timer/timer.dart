import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constracts.dart';
import '../../../providers/questions.dart';
import '../../../widgets/styled_text.dart';
import '../../questions/completed.dart';

class Timer extends StatelessWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final question = Provider.of<QuestionInfo>(context);

    return TweenAnimationBuilder<Duration>(
        duration: const Duration(minutes: 2),
        tween: Tween(begin: const Duration(minutes: 2), end: Duration.zero),
        onEnd: () {
          question.updateStopped();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Completed(score:question.score)),
          );
        },
        builder: (BuildContext context, Duration value, Widget? child) {
          final minutes = value.inMinutes;
          final seconds = value.inSeconds % 60;
          String secondsStr = '$seconds';
          bool less = false;

          if (seconds < 10) {
            secondsStr = '0$seconds';
            less = true;
          }

          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: CustomText(
                  data: '$minutes:$secondsStr',
                  color: less ? Colors.red : blueColor,
                  size: 33.0));
        });
  }
}
