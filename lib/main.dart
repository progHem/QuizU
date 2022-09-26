import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'intro_screens.dart';
import 'providers/providers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: IntroScreens()),
    );
  }
}
