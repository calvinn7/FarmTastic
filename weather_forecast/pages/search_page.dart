import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE7F7D3),

      appBar: AppBar(
        title: Text('Search Weather'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(labelText: 'Enter location'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Perform the search based on the entered location
                String searchLocation = _searchController.text;
                // Call your weather API or service to get weather information for the searchLocation
                // Example: _getWeatherForLocation(searchLocation);
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }

// You can implement the method to get weather information for the entered location
// void _getWeatherForLocation(String location) {
//   // Call your weather API or service here
//   // Update the UI with the weather information
// }
}
