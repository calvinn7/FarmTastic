import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFADBC8D),
      appBar: AppBar(
        title: const Text(
          'About App',
        ),
        backgroundColor: const Color(0xFFF9FFDF),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Color(0xFF567D01),
          fontSize: 20.0, // Set the text size
          fontWeight: FontWeight.w900, // Set the font weight
        ),
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(),
        ),
        const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'FarmTastic is your one-stop solution for all things farming. Whether you are a seasoned farmer or just starting, we provide tools and information to help you succeed in your agricultural endeavors.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    // Image.asset('assets/images/farm.jpg'),
                    SizedBox(height: 10),
                    Text(
                      'Explore our features, including real-time weather updates and forecast, a comprehensive farming calendar, '
                          'a carbon calculator to assess your environmental impact, and a vibrant community to connect with fellow farmers. ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    // Image.asset('assets/images/smart.jpg'),
                    SizedBox(height: 10),
                    Text(
                      'Join FarmTastic and grow your farm with confidence!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
