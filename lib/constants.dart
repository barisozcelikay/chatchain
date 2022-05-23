// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

const Color darkColor = Color(0xFF1B212C);
const Color lightColor = Colors.white;

final appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);

const kPrimaryColor = Color.fromARGB(255, 222, 0, 0);
const kSecondaryColor = Color(0xFFFE9901);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

const kDefaultPadding = 20.0;

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kappDarkenColor = Color(0xFF1D1D35);
const kappLightDarkenColor = Color.fromARGB(255, 102, 102, 147);
