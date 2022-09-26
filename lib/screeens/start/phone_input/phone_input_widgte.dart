// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:phone_number/phone_number.dart';
import 'package:provider/provider.dart';

import '../../../constracts.dart';
import '../../../providers/auth.dart';

class PhoneInput extends StatefulWidget {
  const PhoneInput({Key? key}) : super(key: key);

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  late String fullNumber;
  String code = '+966';

  @override
  void initState() {
    super.initState();
//validate();
  }

  Future<bool> validate(String number, String code) async {
    String numberSimple = '${code}${number}';
    bool isValid = await PhoneNumberUtil().validate(numberSimple);
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    final phone = Provider.of<Phone>(context);

    return IntlPhoneField(
      decoration: const InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: grayColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: orangeColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: grayColor),
          ),
          filled: true,
          fillColor: whiteColor,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 19)),
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      initialCountryCode: 'SA',
      onCountryChanged: (country) {
        setState(() {
          code = '+{$country.dialCode}';
        });
      },
      onSubmitted: (phoneNumber) async {
        setState(() {
          fullNumber = phoneNumber;
        });
        bool valid = await validate(fullNumber, code);
        if (valid) {
          phone.changeValid();
          phone.updatePhone(fullNumber);
        } else {
          phone.setToFalse();
        }
      },
    );
  }
}
