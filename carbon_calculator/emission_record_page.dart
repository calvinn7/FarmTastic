// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../authentication/features/profile_controller.dart';
import 'firebase.dart';

class EmissionRecordPage extends StatefulWidget {
  // ignore: use_super_parameters
  const EmissionRecordPage({Key? key}) : super(key: key);

  @override
  _EmissionRecordPageState createState() => _EmissionRecordPageState();
}

class _EmissionRecordPageState extends State<EmissionRecordPage> {
  List<Map<String, dynamic>> emissionData = [];
  late DateTime _selectedDate;
  List<DateTime> allDates = [];

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    loadEmissionData(_selectedDate);
    loadAllDates();
  }

  Future<List<DateTime>> loadAllDates() async {
    ProfileController controller = Get.find<ProfileController>();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(controller.userData.value!.id)
        .collection('carbon_emissions')
        .get();

    allDates.clear();
    for (var doc in snapshot.docs) {
      DateTime date = DateTime.parse(doc['selectedDate'] as String);
      allDates.add(date);
    }
    return allDates;
  }

  Future<void> loadEmissionData(DateTime date) async {
    DateTime dateWithoutTime = DateTime(date.year, date.month, date.day);

    List<Map<String, dynamic>> data =
        await FirebaseService.instance.getSelectedDateEmissionsF(dateWithoutTime);

    data.sort((a, b) {
      DateTime dateA = DateTime.parse(a['currentDate']);
      DateTime dateB = DateTime.parse(b['currentDate']);
      return dateB.compareTo(dateA);
    });

    if (mounted) {
      setState(() {
        emissionData = data;
      });
    }
  }

  Future<void> deleteEmission(String docId) async {
    await FirebaseService.instance.deleteSelectedDateEmissionF(docId);
    loadEmissionData(_selectedDate);
    loadAllDates();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FFDF),
        elevation: 0,
        title: const Text('Emission Records'),
        titleTextStyle: const TextStyle(
          color: Color(0xFF567D01),

          fontSize: 20.0, // Set the text size

          fontWeight: FontWeight.w900, // Set the font weight
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
      body: Column(

        children: [
          const SizedBox(height: 10.0),
          StatefulBuilder(
            builder: (context, setState) {
              return Container(
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFDDECCB),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      // Set the shadow color
                      spreadRadius: 5,
                      // Set the spread radius of the shadow
                      blurRadius: 7,
                      // Set the blur radius of the shadow
                      offset: const Offset(0, 3), // Set the offset of the shadow
                    ),
                  ],
                ),
                child: TableCalendar(
                  focusedDay: _selectedDate,
                  firstDay: DateTime(2022),
                  lastDay: DateTime(2030, 12, 31),
                  onDaySelected: (selectedDate, focusedDate) {
                    setState(() {
                      _selectedDate = selectedDate;
                      loadEmissionData(_selectedDate);
                    });
                  },
                  calendarFormat: CalendarFormat.month,
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, date, events) {
                      bool isSelectedDay = isSameDay(_selectedDate, date);
                      bool hasEmissionRecord =
                      allDates.contains(DateTime(date.year, date.month,date.day));

                      return Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelectedDay
                                  ? const Color.fromARGB(255, 96, 139, 4)
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                '${date.day}',
                                style: TextStyle(
                                  color: isSelectedDay
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),

                          // Dot below the date indicating emission record
                          if (hasEmissionRecord)
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 96, 139,
                                      4), // Change color as needed
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  headerStyle: const HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    // Hide the format button
                  ),
                  onFormatChanged: (CalendarFormat format) {
                    if (format == CalendarFormat.twoWeeks) {
                      setState(() {});
                    }
                  },
                ),
              );
            },
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Positioned(
                  top: (30.0 - 2.0) / 2,
                  left: 0,
                  child: Container(
                    width: 14.0,
                    height: 2.0,
                    color: const Color.fromARGB(255, 61, 88, 2),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 14.0), // Adjust left padding as needed
                      child: Text(
                        'Your Records',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 61, 88, 2),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: (30.0 - 2.0) / 2,
                  right: 0,
                  child: Container(
                    width: 257.0,
                    height: 2.0,
                    color: const Color.fromARGB(255, 61, 88, 2),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
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
                    'Edited Date: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(emission['currentDate']))}',
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
        ],
      ),
    );
  }
}
