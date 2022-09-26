import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_u/constracts.dart';

import '../providers/auth.dart';

class StyledField extends StatefulWidget {
  const StyledField({Key? key}) : super(key: key);

  @override
  State<StyledField> createState() => _StyledFieldState();
}

class _StyledFieldState extends State<StyledField> {
  final myController = TextEditingController();
  bool validate = true;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> state = GlobalKey<FormState>();
    final user = Provider.of<User>(context);

    return TextFormField(
      key: state,
      controller: myController,
      onChanged: (text) {
        user.username = text;
      },
      decoration: InputDecoration(
        errorText: user.validate ? 'Value Can\'t Be Empty' : null,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: orangeColor),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: grayColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.all(13.5),
        focusColor: blueColor,
      ),
    );
  }
}
