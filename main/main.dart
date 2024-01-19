import 'package:farmtastic/authentication/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'authentication/features/profile_controller.dart';
import 'authentication/firebase_options.dart';
import 'authentication/pages/login_or_register_page.dart';
import 'authentication/repository/authentication_repository/authentication_repository.dart';
import 'calendar/Calendar/calendar_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await NotifyHelper().initializeNotification();
  // await DBHelper.initDb();
  // await DbHelper.initDb();
  await GetStorage.init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepository()));

  // Initialize ProfileController
  Get.put(ProfileController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CalendarModel(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthPage(),
        ));
  }
}
