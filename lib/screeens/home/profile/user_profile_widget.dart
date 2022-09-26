// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_u/loading.dart';
import 'package:quiz_u/widgets/styled_box.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constracts.dart';
import '../../../sharedPrefernce/shared_preference.dart';
import '../../../widgets/styled_text.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var data;
  var mobile = '';
  bool _isLoaded = true;

  List scores = [];
  List newList = [];

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    var token = await getFromPref('token');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var scoresFromPref = prefs.getStringList('scores');

    if (scoresFromPref == null) {
      scores = [];
    } else {
      scores = scoresFromPref;
      for (int i = 0; i < scores.length; i++) {
        newList.add(json.decode(scores[i]));
      }
      newList.sort((a, b) => b['datetime'].compareTo(a['datetime']));
      scores = newList;
    }

    var url = Uri.parse('https://quizu.okoul.com/UserInfo');
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});

    var jsonresponse = jsonDecode(response.body);

    setState(() {
      data = jsonresponse;
      _isLoaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: whiteColor,
          centerTitle: true,
          title: const QuizLogo(),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const CustomText(
                            data: 'Do you really want to logout?',
                            size: 18,
                            color: blackColor),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const CustomText(data: 'No', color: blueColor)),
                          TextButton(
                              onPressed: () {
                                removeFromPref('token');
                                removeFromPref('scores');
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Loading()));
                              },
                              child:
                                  const CustomText(data: 'Yes', color: orangeColor))
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.logout, color: orangeColor, size: 28.0)),
          ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: height, minWidth: width),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.02),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                    backgroundColor: orangeColor,
                    radius: 70.0,
                  ),
                  SizedBox(height: height * 0.04),
                  _isLoaded
                      ? const CircularProgressIndicator(
                          color: blueColor,
                        )
                      : Column(
                          children: [
                            StyledBox(
                              width: width,
                              height: height * 0.17,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    data: 'Name: ${data['name']}',
                                    size: 22,
                                  ),
                                  SizedBox(height: height * 0.01),
                                  CustomText(
                                    data: 'Mobile: ${data['mobile']}',
                                    size: 22,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.04),
                            StyledBox(
                              width: width,
                              height: height * 0.33,
                              lColor: orangeColor,
                              fColor: const Color.fromARGB(255, 233, 148, 44),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(height: height * 0.01),
                                  const CustomText(
                                    data: 'My Score',
                                    weight: FontWeight.w700,
                                    size: 25,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Divider(
                                      color: whiteColor,
                                      thickness: 0.8,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  scores.isNotEmpty
                                      ? SingleChildScrollView(
                                          child: SizedBox(
                                            height: height * 0.20,
                                            child: ListView.builder(
                                                itemCount: scores.length,
                                                itemBuilder: (context, index) {
                                                  final item = scores[index];
                                                  return ScoreRow(item: item);
                                                }),
                                          ),
                                        )
                                      : const CustomText(
                                          data:
                                              'You have no scores yet!, Play Now!',
                                          align: TextAlign.center),
                                  SizedBox(height: height * 0.01),
                                ],
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScoreRow extends StatelessWidget {
  final item;
  const ScoreRow({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomText(
            data: '${item['time']} ${item['date']}',
            size: 20,
          ),
          CustomText(
            data: '${item['score']}',
            size: 20,
          ),
        ],
      ),
    );
  }
}
