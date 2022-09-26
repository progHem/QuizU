import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_u/screeens/home/leaderborad/leader_board_list.dart';

import '../../../constracts.dart';
import '../../../models/leader.dart';
import '../../../sharedPrefernce/shared_preference.dart';
import '../../../widgets/styled_text.dart';
import 'package:http/http.dart' as http;

class LeaderBoard extends StatefulWidget {
  const LeaderBoard({Key? key}) : super(key: key);

  @override
  State<LeaderBoard> createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  List users = [];

  @override
  void initState() {
    super.initState();
    getLeaderBoard();
  }

  Future getLeaderBoard() async {
    var token = await getFromPref('token');

    var url = Uri.parse('https://quizu.okoul.com/TopScores');
    var response =
        await http.get(url, headers: {"Authorization": "Bearer $token"});

    var jsonresponse = jsonDecode(response.body);
    List<TopUsers> users = [];

    for (var u in jsonresponse) {
      TopUsers user = TopUsers(name: u['name'], score: u['score']);
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          //fit: BoxFit.fill,
                          image: AssetImage(
                        'assets/images/leader.png',
                      )),
                    )),
                SizedBox(height: height * 0.01),
                const CustomText(
                    data: 'LeaderBoard',
                    color: blueColor,
                    weight: FontWeight.w700,
                    size: 35.0,
                    align: TextAlign.center),
                SizedBox(height: height * 0.01),
                FutureBuilder(
                  future: getLeaderBoard(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const CircularProgressIndicator(
                        color: blueColor,
                      );
                    } else {
                      return LeaderBoardListView(users: snapshot.data);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
