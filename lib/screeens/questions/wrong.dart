import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quiz_u/constracts.dart';
import 'package:quiz_u/screeens/questions/question_widget.dart';
import 'package:quiz_u/widgets/styled_btn.dart';
import 'package:quiz_u/widgets/styled_text.dart';

import '../home/home.dart';

class Wrong extends StatelessWidget {
  const Wrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                 Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
                      
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
                    SizedBox(height: height * 0.10),
                    SizedBox(
                      width: width,
                      height: height * 0.30,
                      child: SvgPicture.asset(
                        'assets/images/wrong.svg',
                      ),
                    ),
                    SizedBox(height: height * 0.06),
                    const CustomText(
                        data: 'Wrong Answer',
                        color: blackColor,
                        size: 27.0),
                  
                    SizedBox(height: height * 0.03),
                    SizedBox(
                      width: width*0.30,
                      child: StyledBtn(onPress: (){
                         Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Question()));
                      }, data: 'Try Again', color:blueColor))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
