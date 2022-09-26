import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:quiz_u/constracts.dart';
import 'package:quiz_u/loading.dart';
import 'package:quiz_u/widgets/styled_text.dart';

import 'widgets/styled_btn.dart';

class IntroScreens extends StatefulWidget {
  const IntroScreens({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _IntroScreensState createState() => _IntroScreensState();
}

class _IntroScreensState extends State<IntroScreens> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const Loading()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 30.0,
          color: blueColor,
          fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18.0,
          color: blackColor,
          fontWeight: FontWeight.w500),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.only(top: 100.0),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: whiteColor,
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: StyledBtn(
          color: blueColor,
          cirular: 0.0,
          onPress: () => _onIntroEnd(context),
          data: 'Let\'s Start',
        ),
      ),
      pages: [
        PageViewModel(
          title: "Quiz U App",
          body: "Help you to test your knowledge, By doing Quizes!",
          image: _buildImage('intro1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Login in, And Play",
          body: "You can login by your phone number and just take the quiz!",
          image: _buildImage('intro2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Challenge your frinds",
          body: "challenge the other to get into the leaderboard list!",
          image: _buildImage('leader.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      backStyle: ButtonStyle(foregroundColor: MaterialStateProperty.all(orangeColor)),
      nextStyle: ButtonStyle(foregroundColor: MaterialStateProperty.all(orangeColor)),
      back: const Icon(Icons.arrow_back),
      skip: const CustomText(data: 'Skip', color:orangeColor, weight: FontWeight.w500),
      next: const Icon(Icons.arrow_forward, size: 30.0,),
      done: const CustomText(data: 'Done', color: orangeColor, weight: FontWeight.w500),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: grayColor,
        activeColor: orangeColor,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
