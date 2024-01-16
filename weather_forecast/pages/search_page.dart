import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:farmtastic/main/consts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late DateTime _selectedDate;
  late int _forecastDuration;

  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _currentWeather;
  List<Weather>? _weatherForecast;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _forecastDuration = 1; // Default forecast duration is 1 day
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFADBC8D),
      appBar: AppBar(
        title: const Text('Weather Forecast'),
        backgroundColor: const Color(0xFFF9FFDF),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Color(0xFF567D01),

          fontSize: 20.0, // Set the text size

          fontWeight: FontWeight.w900, // Set the font weight
        ),      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Date:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                _selectDate(context);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 10),
                    Text(
                      DateFormat('dd MMMM yyyy').format(_selectedDate),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Forecast Duration:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<int>(
              value: _forecastDuration,
              onChanged: (value) {
                setState(() {
                  _forecastDuration = value!;
                });
              },
              items: [
                const DropdownMenuItem<int>(
                  value: 1,
                  child: Text('1 Day'),
                ),
                const DropdownMenuItem<int>(
                  value: 7,
                  child: Text('1 Week'),
                ),
                const DropdownMenuItem<int>(
                  value: 14,
                  child: Text('2 Weeks'),
                ),
                const DropdownMenuItem<int>(
                  value: 28,
                  child: Text('4 Weeks'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _getWeatherForDateRange(_selectedDate, _forecastDuration);
              },
              child: const Text('Get Weather Forecast'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _getWeatherForDateRange(
      DateTime selectedDate, int forecastDuration) async {
    try {
      // Load weather forecast for the next 5 days (or any reasonable duration)
      List<Weather> weatherForecast =
          await _wf.fiveDayForecastByCityName("Kuala Lumpur");

      // Filter the forecast data based on the selected date and duration
      DateTime endDate = selectedDate.add(Duration(days: forecastDuration - 1));
      List<Weather> filteredForecast = weatherForecast
          .where((forecast) =>
              forecast.date!
                  .isAfter(selectedDate.subtract(const Duration(days: 1))) &&
              forecast.date!.isBefore(endDate.add(const Duration(days: 1))))
          .toList();

      // Update the UI with the filtered forecast information
      setState(() {
        _weatherForecast = filteredForecast;
      });

      // Clear any previous error message
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
    } catch (e) {
      // Display an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error fetching weather data. Please try again later.'),
          backgroundColor: Colors.red,
        ),
      );
      print("Error fetching weather data: $e");
    }
  }
}
