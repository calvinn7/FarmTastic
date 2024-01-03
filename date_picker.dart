import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DatePicker {
  static Future<DateTime?> showDatePickerModal(BuildContext context, DateTime initialDateTime) async {
    DateTime? pickedDate;
    DateTime initialDateTime = DateTime.now();

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 233, 241, 195),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          color: Color.fromARGB(255, 61, 88, 2),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 150,
                  child: CupertinoDatePicker(
                    backgroundColor: const Color.fromARGB(255, 233, 241, 195),
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: initialDateTime,
                    onDateTimeChanged: (DateTime newDateTime) {
                      pickedDate = newDateTime;
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    return pickedDate;
  }
}
