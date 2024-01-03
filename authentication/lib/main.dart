import 'package:farmtastic/features/controllers/profile_controller.dart';
import 'package:farmtastic/pages/auth_page.dart';
import 'package:farmtastic/pages/login_or_register_page.dart';
import 'package:farmtastic/pages/login_page.dart';
import 'package:farmtastic/pages/profile/profile_page.dart';
import 'package:farmtastic/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginOrRegisterPage(),
// initialRoute: '/',
//       routes: {
//         // '/': (context) => HomePage(),
//         '/login': (context) => const LoginPage(onTap: () {  },),
//         '/profile': (context) => const ProfilePage(),
//         // ... other routes
//       },
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Login Page'),
      //   ),
      //   body: SingleChildScrollView(
      //     child: LoginPage(),
      //   ),
      // ),
    );
  }
}
