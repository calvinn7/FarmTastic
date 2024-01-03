import 'package:farmtastic/Database/task_database_helper.dart';
import 'package:farmtastic/farming_calendar.dart';
import 'package:farmtastic/calendar_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'TaskReminder/notification_services.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotifyHelper().initializeNotification();
  await DBHelper.initDb();
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CalendarModel(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FarmingCalendar(),
        ));
  }
}
