import 'package:weather_forecast/consts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_forecast/pages/home.dart';
import 'search_page.dart';
import 'alerts_page.dart';
import 'home.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({Key? key}) : super(key: key);

  @override
  State<WeatherHome> createState() => _HomePageState();
}

class _HomePageState extends State<WeatherHome> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _currentWeather;
  List<Weather>? _weatherForecast;

  @override
  void initState() {
    super.initState();
    _loadWeatherData();
  }

  Future<void> _loadWeatherData() async {
    // Load current weather
    Weather currentWeather = await _wf.currentWeatherByCityName("Kuala Lumpur");
    setState(() {
      _currentWeather = currentWeather;
    });

    // Load weather forecast
    List<Weather> weatherForecast =
    await _wf.fiveDayForecastByCityName("Kuala Lumpur");
    setState(() {
      _weatherForecast = weatherForecast;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7F7D3),
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Weather Forecast'),
        actions: [
      IconButton(
      icon: const Icon(Icons.notifications),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WeatherAlertsPage()),
        );
      },
      ),

          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Navigate to the search page when the search button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFE7F7D3),
              ),
              child: Center(
                child: Text(
                  'FarmTastic',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,

                  ),
                ),
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
                  MaterialPageRoute(builder: (context) => HomePage()),
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {

    if (_currentWeather == null || _weatherForecast == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        _locationHeader(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        _dateTimeInfo(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        _weatherIcon(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        _currentTemp(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        _extraInfo(),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        const Text(
          'Today Forecast',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        _hourlyForecastList(), // Display the weather forecast
        const Text(
          'Daily Forecast',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        _dailyForecastList(),
      ],
    );
  }
  Widget _locationHeader() {
    return Text(
      _currentWeather?.areaName ?? "",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _currentWeather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(
            fontSize: 35,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              " ${now.day}.${now.month}.${now.year}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            height: MediaQuery
                .sizeOf(context)
                .height * 0.2,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "http://openweathermap.org/img/wn/${_currentWeather
                          ?.weatherIcon}@4x.png")
              ),
            )
        ),
        Text(
          _currentWeather?.weatherDescription ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),

        ),

      ],

    );
  }

  Widget _currentTemp() {
    return Text(
      "${_currentWeather?.temperature?.celsius?.toStringAsFixed(0)}°C",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 60,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
      height: MediaQuery
          .sizeOf(context)
          .height * 0.05,
      width: MediaQuery
          .sizeOf(context)
          .height * 0.40,
      decoration: BoxDecoration(
          color: Colors.lightGreen, borderRadius: BorderRadius.circular(
          20
      )
      ),
      padding: const EdgeInsets.all(
          8.0
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Wind: ${_currentWeather?.windSpeed?.toStringAsFixed(0)}m/s",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                "Humidity: ${_currentWeather?.humidity?.toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
  Widget _hourlyForecastList() {
    // Filter hourly forecasts for today
    List<Weather> hourlyForecastsToday = _weatherForecast!
        .where((forecast) =>
    forecast.date?.day == DateTime.now().day &&
        forecast.date?.month == DateTime.now().month &&
        forecast.date?.year == DateTime.now().year)
        .toList();
    // Print the length of hourlyForecastsToday to the console
    print("Number of hourly forecasts for today: ${hourlyForecastsToday.length}");

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: hourlyForecastsToday.map((hourlyForecast) {
          DateTime forecastTime = hourlyForecast.date!;

          return Container(
            width: MediaQuery.of(context).size.width * 0.3,
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  DateFormat("h:mm a").format(forecastTime),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.0),
                Image.network(
                  "http://openweathermap.org/img/wn/${hourlyForecast.weatherIcon}@2x.png",
                  height: 40,
                  width: 40,
                ),
                SizedBox(height: 8.0),
                Text(
                  "${hourlyForecast.temperature?.celsius?.toStringAsFixed(0)}°C",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }



  Widget _dailyForecastList() {
    Map<String, List<Weather>> dailyForecasts = {};

    // Group hourly forecasts by day
    for (Weather forecast in _weatherForecast!) {
      DateTime forecastDate = forecast.date!;
      String formattedDate = DateFormat("d MMMM").format(forecastDate);

      if (!dailyForecasts.containsKey(formattedDate)) {
        dailyForecasts[formattedDate] = [];
      }

      dailyForecasts[formattedDate]!.add(forecast);
    }

    return Column(

      children: dailyForecasts.keys.map((date) {
        List<Weather> dailyForecast = dailyForecasts[date]!;

        // Calculate min-max temperatures for the day
        double minTemp = double.infinity;
        double maxTemp = double.negativeInfinity;

        for (Weather forecast in dailyForecast) {
          if (forecast.tempMin?.celsius != null &&
              forecast.tempMax?.celsius != null) {
            minTemp = forecast.tempMin!.celsius! < minTemp
                ? forecast.tempMin!.celsius!
                : minTemp;
            maxTemp = forecast.tempMax!.celsius! > maxTemp
                ? forecast.tempMax!.celsius!
                : maxTemp;
          }
        }

        return ListTile(
          title: Text(
            date,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: Text(
            "Min: ${minTemp.toStringAsFixed(0)}°C, Max: ${maxTemp.toStringAsFixed(0)}°C",
          ),
          // You can customize the ListTile with more forecast details as needed
        );
      }).toList(),
    );
  }

}