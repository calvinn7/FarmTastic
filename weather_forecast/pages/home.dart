import 'package:flutter/material.dart';
import 'package:weather_forecast/pages/weather_home.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      backgroundColor: const Color(0xFFE7F7D3),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', height: 80, width: 80),
                  SizedBox(height: 10),
                  Text(
                    'FarmTastic',
                    style: TextStyle(
                      color: Color(0xFFE7F7D3),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                // Navigate back to the home page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              title: Text('Weather'),
              onTap: () {
                // Navigate to Weather page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherHome()),
                );
              },
            ),
            ListTile(
              title: Text('Farming Calendar'),
              onTap: () {
                // Navigate to Weather page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              title: Text('Carbon Calculator'),
              onTap: () {
                // Navigate to Weather page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            ListTile(
              title: Text('Community'),
              onTap: () {
                // Navigate to Weather page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'My Account',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'FarmTastic',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 200, width: 200),
              Text(
                'Welcome to',
                style: TextStyle(fontSize: 35),
              ),
              Center(
                child: Text(
                  'FarmTastic!',
                  style: TextStyle(
                    fontSize: 41,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Text(
                'Introduction',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'FarmTastic is your one-stop solution for all things farming. Whether you are a seasoned farmer or just starting, we provide tools and information to help you succeed in your agricultural endeavors.',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.justify,

              ),
              SizedBox(height: 10),
              Image.asset('assets/images/farm.jpg'),
              SizedBox(height: 10),
              Text(
                'Explore our features, including real-time weather updates and forecast,   a comprehensive farming calendar, '
                    'a carbon calculator to assess your environmental impact, and a vibrant community to connect with fellow farmers. ',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10),
              Image.asset('assets/images/smart.jpg'),
              SizedBox(height: 10),

              Text(
           'Join FarmTastic and grow your farm with confidence!',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
