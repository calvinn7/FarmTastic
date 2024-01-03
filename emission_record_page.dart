// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, avoid_print

import 'database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class EmissionRecordPage extends StatefulWidget {
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
    List<Map<String, Object?>> dateData =
        await DatabaseService.instance.getAllDates();

    for (var dateInfo in dateData) {
      if (dateInfo['selectedDate'] != null) {
        DateTime date = DateTime.parse(dateInfo['selectedDate']! as String);
        allDates.add(date);
      }
    }

    return allDates;
  }

  Future<void> loadEmissionData(DateTime date) async {
    emissionData =
        await DatabaseService.instance.getSelectedDateEmissions(date);
    setState(() {});
  }

  Future<void> deleteEmission(int id) async {
    await DatabaseService.instance.deleteSelectedDateEmission(id);

    bool hasRemainingRecords = await DatabaseService.instance
        .getSelectedDateEmissions(_selectedDate)
        .then((records) => records.isNotEmpty);

    if (!hasRemainingRecords) {
      allDates.removeWhere((date) => isSameDay(date, _selectedDate));
    }

    loadEmissionData(_selectedDate);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emission Records'),
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
      body: Column(
        children: [
          StatefulBuilder(
            builder: (context, setState) {
              return TableCalendar(
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
                    bool hasEmissionRecord = allDates.contains(date);

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
                                color:
                                    isSelectedDay ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        // Dot below the date indicating emissions

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
                                color: Color.fromARGB(
                                    255, 96, 139, 4), // Change color as needed
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
              );
            },
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 216, 237, 170),
            ),
            onPressed: () async {
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime.now().add(const Duration(days: 7300)),
              );

              if (selectedDate != null) {
                setState(() {
                  _selectedDate = selectedDate;
                  loadEmissionData(_selectedDate);
                });
              }
            },
            child: Text(
              'Select Date: ${DateFormat.yMd().format(_selectedDate)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: emissionData.length,
              itemBuilder: (context, index) {
                final emission = emissionData[index];
                return ListTile(
                  title: Text(
                    'Carbon Emissions: ${emission['emissions'].toStringAsFixed(2)} CO2',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Selected Date: ${DateFormat.yMd().format(DateTime.parse(emission['selectedDate']))}',
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => deleteEmission(emission['id']),
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
