import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/style/them.dart';

import 'CachHelper.dart';
import 'cubit/cubit.dart';
import 'modules/loagin/loginScreen.dart';

Widget REFormField({
  required TextEditingController controller,
  required TextInputType type,
  required validator,
  required label,
  required prefix,
  suffix,
  obscureText,
  onsave,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: TextFormField(
      onChanged: onsave,
      obscureText: obscureText,
      controller: controller,
      keyboardType: type,
      validator: validator,
      decoration: InputDecoration(
        suffix: suffix,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        label: label,
        prefixIcon: prefix,
      ),
    ),
  );
}

Widget REButton(onPressed, String text) {
  return Container(
    padding: EdgeInsets.all(10),
    height: 70,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(text.toUpperCase()),
    ),
  );
}

Widget RETextButton(onPressed, String text) {
  return TextButton(
    onPressed: onPressed,
    child: Text('$text'),
  );
}

enum ToastState { SUCCESS, ERROR, WARNING }

Color choseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

void ShowToast({required String message, required ToastState ToastState}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choseToastColor(ToastState),
      textColor: Colors.white,
      fontSize: 16.0,
    );

void logout(context) {
  CachHelper.removeData('token').then(
    (value) {
      if (value == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    },
  );
}

String token = '';
