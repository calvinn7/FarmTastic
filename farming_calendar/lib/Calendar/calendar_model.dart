import 'package:flutter/material.dart';

class CalendarModel extends ChangeNotifier {
  DateTime _first = DateTime.now();
  DateTime _second = DateTime.now().add(const Duration(days: 1));

  // Return selected first date
  DateTime get firstDate {
    return _first;
  }

  // Return selected second date
  DateTime get secondDate {
    return _second;
  }

  // Notify the app that a date range have been selected
  void getDateRange(DateTime first, DateTime second) {
    _first = first;
    _second = second;
    notifyListeners();
  }
}
