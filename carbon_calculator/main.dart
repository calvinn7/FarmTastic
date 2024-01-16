// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'carbon_calc_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carbon Emission Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF9FFDF),
        ),
      ),
      home: const CarbonCalculatorPage(),
    );
  }
}

