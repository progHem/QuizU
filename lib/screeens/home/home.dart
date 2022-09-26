import 'package:flutter/material.dart';
import 'package:quiz_u/screeens/home/leaderborad/leader_board.dart';
import 'package:quiz_u/screeens/home/profile/user_profile_widget.dart';
import '../../constracts.dart';
import 'home_widgte/home_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int currentTab = 0;

  bool isSelected = false;

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: const <Widget>[
        HomeWidget(),
        LeaderBoard(),
        Profile(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      currentTab = index;
      isSelected = !isSelected;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      currentTab = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: BottomAppBar(
        color: blueColor,
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                size: 31.0,
                color: currentTab == 0 ? orangeColor : whiteColor,
              ),
              onPressed: () {
                bottomTapped(0);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.school_sharp,
                size: 31.0,
                color: currentTab == 1 ? orangeColor : whiteColor,
              ),
              onPressed: () {
                bottomTapped(1);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.account_circle_sharp,
                size: 31.0,
                color: currentTab == 2 ? orangeColor : whiteColor,
              ),
              onPressed: () {
                bottomTapped(2);
              },
            ),            
          ],
        ),
      ),
    );
  }
}