import 'package:farmtastic/calendar/Calendar/calendar_model.dart';
import 'package:farmtastic/calendar/Calendar/clean_calendar_controller.dart';
import 'package:farmtastic/calendar/Calendar/scrollable_calendar.dart';
import 'package:farmtastic/calendar/Crop/crop_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';

import '../services/theme.dart';
import 'crop.dart';

class CropSchedulingPage extends StatefulWidget {
  @override
  _CropSchedulingPageState createState() => _CropSchedulingPageState();
}

class _CropSchedulingPageState extends State<CropSchedulingPage> {
  final CropController _cropController = Get.put(CropController());
  String cropName = '';
  int duration = 30; // Default duration in days
  int _selectedColor = 0;

  final calendarController = CleanCalendarController(
    minDate: DateTime.now(),
    maxDate: DateTime.now().add(
      const Duration(days: 733),
    ),
    weekdayStart: DateTime.monday,
  );
  DateTime? _start = DateTime.now();
  DateTime? _end = DateTime.now();

  @override
  void initState() {
    super.initState();
    _cropController.getCrops();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crop Scheduling"),
        backgroundColor: const Color(0xFFF9FFDF),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Color(0xFF567D01),
          fontSize: 20.0, // Set the text size
          fontWeight: FontWeight.w900, // Set the font weight
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Set the shadow color
                  spreadRadius: 5, // Set the spread radius of the shadow
                  blurRadius: 10, // Set the blur radius of the shadow
                  offset: const Offset(0, 3), // Set the offset of the shadow
                ),
              ],
              color: const Color(0xFFDDECCB),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
            height: 190.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Plant:",
                      style: titleStyle,
                    ),
                    const SizedBox(width: 30),
                    const SizedBox(height: 20),
                    Container(
                      width: 150.0,
                      height: 45.0,
                      child: TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF8A9D5F),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                              left: 20.0, top: 2.0, bottom: 5.0),
                        ),
                        onChanged: (value) {
                          setState(() {
                            cropName = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      "Duration:",
                      style: titleStyle,
                    ),
                    const SizedBox(width: 9),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF567D01),
                        ),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: DropdownButton<int>(
                          value: duration,
                          items: List.generate(
                            30,
                            (index) => DropdownMenuItem<int>(
                              value: index + 1,
                              child: Text('${index + 1} days'),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              duration = value!;
                            });
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Color:",
                      style: titleStyle,
                    ),
                    const SizedBox(width: 29),
                    _colorPlatte(),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                  left: 10, top: 20, right: 10, bottom: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Set the shadow color
                    spreadRadius: 5, // Set the spread radius of the shadow
                    blurRadius: 7, // Set the blur radius of the shadow
                    offset: const Offset(0, 3), // Set the offset of the shadow
                  ),
                ],
                color: const Color(0xFFDDECCB),
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
              height: 300.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Select Date Range:",
                        style: titleStyle,
                      ),
                      const SizedBox(width: 15),
                    ],
                  ),
                  const SizedBox(
                    height:
                        5.0, // Add some space between text fields and calendar
                  ),
                  Container(
                    child: const Column(
                      children: [],
                    ),
                  ),
                  Expanded(
                    child: ScrollableCleanCalendar(
                      calendarController: calendarController,
                      layout: Layout.DEFAULT,
                      calendarCrossAxisSpacing: 10,
                      calendarMainAxisSpacing: 10,

                      // Use monthBuilder to customize the appearance for each month
                      monthBuilder: (context, month) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Center(
                            child: Text(month),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Create a button to trigger the crop schedule
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 78.0, right: 15.0),
        child: Consumer<CalendarModel>(
          // Press this button to pass selected date range to main page
          builder: ((context, calendar, child) {
            return FloatingActionButton(
              onPressed: () {
                _validate();
              },
              backgroundColor: Colors.lightGreen,
              mini: true,
              child: const Icon(Icons.done),
            );
          }),
        ),
      ),
    );
  }

  _validate() {
    if (cropName.isEmpty &&
        calendarController.rangeMinDate == null &&
        calendarController.rangeMaxDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All fields are required!"),
        ),
      );
    } else if (cropName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in the plant name"),
        ),
      );
    } else if (calendarController.rangeMinDate == null ||
        calendarController.rangeMaxDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select the date range"),
        ),
      );
    } else if (calendarController.rangeMinDate != null &&
        calendarController.rangeMaxDate != null) {
      _start = calendarController.rangeMinDate;
      _end = calendarController.rangeMaxDate;
      final crop = Crop(
        plant: cropName,
        duration: duration,
        color: _selectedColor,
        startDate: _start != null ? DateFormat.yMd().format(_start!) : '',
        endDate: _end != null ? DateFormat.yMd().format(_end!) : '',
      );
      _cropController.addCrop(crop);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Crop is scheduled"),
        ),
      );
      Navigator.of(context).pop();
    }
  }

  // _addCropToDB() async {
  //   int value = await _cropController.addCrop(
  //       crop: Crop(
  //     plant: cropName,
  //     duration: duration,
  //     color: _selectedColor,
  //     startDate: _start != null ? DateFormat.yMd().format(_start!) : '',
  //     endDate: _end != null ? DateFormat.yMd().format(_end!) : '',
  //   ));
  //   print("Crop id is " + "$value");
  // }

  _colorPlatte() {
    return Wrap(
      children: List<Widget>.generate(4, (int index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedColor = index;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: index == 0
                  ? c1
                  : index == 1
                      ? c2
                      : index == 2
                          ? c3
                          : c4,
              child: _selectedColor == index
                  ? const Icon(
                      Icons.done,
                      color: Colors.black,
                      size: 16,
                    )
                  : Container(),
            ),
          ),
        );
      }),
    );
  }
}
