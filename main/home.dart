import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../authentication/pages/profile_page.dart';
import '../calculator/carbon_calc_page.dart';
import '../calendar/Calendar/calendar_model.dart';
import '../calendar/farming_calendar.dart';
import '../community/community.dart';
import '../weather/weather_home.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FarmTastic',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFADBC8D),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png',
                        height: 150, width: 350),
                    const SizedBox(height: 2),
                    const Text(
                      'Welcome to',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'FarmTastic!',
                      style: TextStyle(
                        fontSize: 41,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                customElevatedButton(
                  'Weather',
                      () {
                    // Navigate to Weather page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WeatherHome()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                customElevatedButton(
                  'Farming Calendar',
                      () {
                    // Navigate to Farming Calendar page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FarmingCalendar()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                customElevatedButton(
                  'Carbon Calculator',
                      () {
                    // Navigate to Carbon Calculator page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CarbonCalculatorPage()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                customElevatedButton(
                  'Community',
                      () {
                    // Navigate to Community page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Consumer<CalendarModel>(
                            builder: (context, calendarModel, child) {
                              return const HomeScreen();
                            },
                          )),
                    );
                  },
                ),
                const SizedBox(height: 20),
                customElevatedButton(
                  'My Account',
                      () {
                    // Navigate to Profile page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfilePage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget customElevatedButton(String label, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFDBEACA)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        elevation: MaterialStateProperty.all<double>(5),
        // Set the shadow elevation
        shadowColor:
        MaterialStateProperty.all<Color>(Colors.green.withOpacity(0.9)),
        // Set the shadow color
        minimumSize: MaterialStateProperty.all<Size>(
            const Size(330, 50)), // Set your desired size
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF000000),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
