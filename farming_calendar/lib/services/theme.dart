import 'package:flutter/material.dart';

const Color c1 = Color(0xFFF1C0EB);
const Color c2 = Color(0xFFCFBAF0);
const Color c3 = Color(0xFFA3C4F3);
const Color c4 = Color(0xFF90DBF4);

TextStyle get headingStyle {
  return const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w900,
  );
}

TextStyle get subHeadingStyle {
  return const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );
}

TextStyle get titleStyle {
  return const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
  );
}

TextStyle get subTitleStyle {
  return const TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}
