// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:quiz_u/screeens/start/start.dart';
import 'package:quiz_u/sharedPrefernce/shared_preference.dart';

import 'constracts.dart';
import 'screeens/home/home.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  dynamic token;

  @override
  void initState() {
    super.initState();
    _navigateTo();
  }

  _navigateTo() async {
    var token = await findToken();

    if (token == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Start()));
    }
  }

  Future<bool> findToken() async {
    WidgetsFlutterBinding.ensureInitialized();
    var token = await getFromPref('token');
    setState(() {
      token = token;
    });
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Visibility(
              visible: true,
              child: CircularProgressIndicator(
                color: orangeColor,
              )),
        ),
      ),
    );
  }
}