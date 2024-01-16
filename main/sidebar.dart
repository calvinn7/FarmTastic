import 'package:farmtastic/authentication/pages/profile_page.dart';
import 'package:farmtastic/calculator/carbon_calc_page.dart';
import 'package:farmtastic/calendar/farming_calendar.dart';
import 'package:farmtastic/community/community.dart';
import 'package:farmtastic/main/home.dart';
import 'package:farmtastic/weather/weather_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../calendar/Calendar/calendar_model.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF9FFDF),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: DividerThemeData(
              color: Colors.grey[600], // Change the color here
            ),
          ),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png',
                        height: 80, width: 80),
                    const SizedBox(height: 10),
                    const Text(
                      'FarmTastic',
                      style: TextStyle(
                        color: Color(0xFF567D01),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              _buildListTile(context, 'Home', Icons.home),
              _buildListTile(context, 'Weather', Icons.cloud),
              _buildListTile(context, 'Farming Calendar', Icons.calendar_today),
              _buildListTile(context, 'Carbon Calculator', Icons.calculate),
              _buildListTile(context, 'Community', Icons.people),
              _buildListTile(context, 'My Account', Icons.account_circle),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[600]!),
        ),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF000000),
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Icon(
          iconData,
          color: const Color(0xFF545D47),
          size: 24,
        ),
        onTap: () {
          // Handle onTap
          switch (title) {
            case 'Home':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
              break;
            case 'Weather':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WeatherHome()),
              );
              break;
            case 'Farming Calendar':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FarmingCalendar()),
              );
              break;
            case 'Carbon Calculator':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CarbonCalculatorPage()),
              );
              break;
            case 'Community':
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Consumer<CalendarModel>(
                          builder: (context, calendarModel, child) {
                            return const HomeScreen();
                          },
                        )),
              );
              break;
            case 'My Account':
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
              break;
          }
        },
      ),
    );
  }
}
