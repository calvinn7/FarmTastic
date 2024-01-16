// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:get/get.dart';

import '../authentication/features/profile_controller.dart';
import 'firebase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmissionHistoryPage extends StatefulWidget {
  const EmissionHistoryPage({super.key});

  @override
  _EmissionHistoryPageState createState() => _EmissionHistoryPageState();
}

class _EmissionHistoryPageState extends State<EmissionHistoryPage> {
  List<Map<String, dynamic>> emissionData = [];
  late ProfileController _profileController;

  @override
  void initState() {
    super.initState();
    _profileController = Get.put(ProfileController());
    _loadUserDataAndEmissionData();
  }

  Future<void> _loadUserDataAndEmissionData() async {
    await _profileController.getUserData();
    loadEmissionData();
  }

  Future<void> loadEmissionData() async {
    if (mounted) {
      emissionData = await FirebaseService.instance.getEmissionsF();
      setState(() {});
    }
  }

  Future<void> deleteEmission(String docId) async {
    await FirebaseService.instance.deleteSelectedDateEmissionF(docId);
    loadEmissionData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emission History'),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 61, 88, 2),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 61, 88, 2),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Color.fromARGB(255, 61, 88, 2),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Add padding around the ListView
        child: ListView.builder(
          itemCount: emissionData.length,
          itemBuilder: (context, index) {
            final emission = emissionData[index];
            final docId = emission['docId'] as String?;
            return ListTile(
              title: Text(
                'Carbon Emissions: ${emission['emissions'].toStringAsFixed(2)} CO2',
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                'Edited Date: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(emission['currentDate']))}\n${emission['selectedDate'] != null ? 'Selected Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(emission['selectedDate']))}\n' : ''}',
                style: const TextStyle(
                  color: Colors.green,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => deleteEmission(docId!),
              ),
            );
          },
        ),
      ),
    );
  }
}
