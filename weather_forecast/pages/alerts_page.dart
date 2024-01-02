import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_forecast/consts.dart';
import 'package:intl/intl.dart';

class WeatherAlertsPage extends StatefulWidget {
  @override
  _WeatherAlertsPageState createState() => _WeatherAlertsPageState();
}

class _WeatherAlertsPageState extends State<WeatherAlertsPage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  List<Map<String, dynamic>>? _rainAlerts;
  List<Map<String, dynamic>>? _thunderstormAlerts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7F7D3),
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Weather Alerts'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: buildAlertList(
              alerts: _rainAlerts,
              alertType: 'Rain',
            ),
          ),
          Expanded(
            child: buildAlertList(
              alerts: _thunderstormAlerts,
              alertType: 'Thunderstorm',
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAlertList({
    List<Map<String, dynamic>>? alerts,
    required String alertType,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$alertType Alerts',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: fetchWeatherAlerts(alertType),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data == null) {
                  return Text('No $alertType alerts available.');
                } else {
                  // Display the weather alerts in a ListView
                  var alerts = snapshot.data as List<Map<String, dynamic>>;

                  return ListView.builder(
                    itemCount: alerts.length,
                    itemBuilder: (context, index) {
                      var alert = alerts[index];
                      return ListTile(
                        title: Text(alert['alertText']),
                        subtitle: Text(
                          'Date: ${DateFormat('yyyy-MM-dd hh:mm a').format(alert['dateTime'])}',
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Map<String, dynamic>>?> fetchWeatherAlerts(String alertType) async {
    try {
      // Fetch weather forecast for the next 5 days
      List<Weather> weatherForecast =
      await _wf.fiveDayForecastByCityName("Kuala Lumpur");

      // Check if there is rain or thunderstorm in the next 5 days
      List<Map<String, dynamic>> rainAlerts = [];
      List<Map<String, dynamic>> thunderstormAlerts = [];

      for (var weather in weatherForecast) {
        if (weather.weatherDescription != null) {
          if (weather.weatherDescription!.toLowerCase().contains("rain")) {
            rainAlerts.add({
              'alertText': 'Rain expected in Kuala Lumpur',
              'dateTime': weather.date,
            });
          } else if (weather.weatherDescription!.toLowerCase().contains("thunderstorm")) {
            thunderstormAlerts.add({
              'alertText': 'Thunderstorm expected in Kuala Lumpur',
              'dateTime': weather.date,
            });
          }
        }
      }

      // Set the appropriate alerts based on the alertType
      List<Map<String, dynamic>> selectedAlerts;
      if (alertType.toLowerCase() == 'rain') {
        selectedAlerts = rainAlerts;
      } else if (alertType.toLowerCase() == 'thunderstorm') {
        selectedAlerts = thunderstormAlerts;
      } else {
        // If the alertType is neither rain nor thunderstorm, return null
        return null;
      }

      return selectedAlerts.isNotEmpty ? selectedAlerts : null;
    } catch (e) {
      print('Error fetching $alertType alerts: $e');
      return null;
    }
  }

}
