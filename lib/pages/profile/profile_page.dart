import 'package:farmtastic/features/controllers/profile_controller.dart';
import 'package:farmtastic/pages/login_or_register_page.dart';
import 'package:farmtastic/posting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../features/authentication/user_model.dart';
import 'update_profile_page.dart';
import 'widgets/profile_menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // void _navigateToUpdateProfilePage(BuildContext context) async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const UpdateProfilePage()),
  //   );
  //   print('Result from UpdateProfilePage: $result');
  //   if (result != null && result as bool) {
  //     // Reload user data or update the UI as needed
  //     await Get.find<ProfileController>().getUserData();
  //   }
  // }

  // Sign user out method
  void signUserOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pop(); // Close the profile page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginOrRegisterPage(),
        ),
      );
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cancel button pressed
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Confirm button pressed, perform logout
                signUserOut(context);

                // Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Log out'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    // var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FFDF),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => const LoginOrRegisterPage(),
              //   ),
              // );
            },
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title:
            Text('Profile', style: Theme.of(context).textTheme.headlineMedium),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon:
        //           Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon)),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;
                  return Builder(builder: (context) {
                    return Column(children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: const Image(
                                  image: AssetImage('lib/images/user.png')),
                              // child: const Icon(LineAwesomeIcons.user,
                              // size: 80.0, color: Colors.black)),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.green[200]),
                                child: const Icon(
                                    LineAwesomeIcons.alternate_pencil,
                                    size: 20.0,
                                    color: Colors.black)),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      // controller.getUserData(),
                      Obx(() {
                        UserModel? userData =
                            ProfileController.instance.userData.value;
                        if (userData != null) {
                          // Update UI with user data
                          return Text(userData.fullName!,
                              style:
                                  Theme.of(context).textTheme.headlineMedium);
                        } else {
                          // Handle case where user data is null
                          return const CircularProgressIndicator();
                        }
                        // child: Text(userData.fullName!,
                        // style: Theme.of(context).textTheme.headlineMedium),
                      }),
                      Obx(() {
                        UserModel? userData =
                            ProfileController.instance.userData.value;
                        if (userData != null) {
                          // Update UI with user data
                          return Text(userData.email!,
                              style: Theme.of(context).textTheme.bodyMedium);
                        } else {
                          // Handle case where user data is null
                          return const CircularProgressIndicator();
                        }
                        // child: Text(userData.fullName!,
                        // style: Theme.of(context).textTheme.headlineMedium),
                      }),
                      // Text(userData.email!,
                      // style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[200],
                              side: BorderSide.none,
                              shape: const StadiumBorder()),
                          onPressed: () {
                            // _navigateToUpdateProfilePage(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const UpdateProfilePage();
                                },
                              ),
                            );
                          },
                          child: const Text('Edit Profile',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Divider(),
                      const SizedBox(height: 10),

                      //Menu
                      ProfileMenuWidget(
                        title: "Settings",
                        icon: LineAwesomeIcons.cog,
                        onPress: () {},
                      ),
                      ProfileMenuWidget(
                          title: "Test",
                          icon: LineAwesomeIcons.wallet,
                          onPress: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return const Posting();
                              },
                            ));
                          }),
                      ProfileMenuWidget(
                          title: "User Management",
                          icon: LineAwesomeIcons.user_check,
                          onPress: () {}),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileMenuWidget(
                          title: "Information",
                          icon: LineAwesomeIcons.info,
                          onPress: () {}),
                      ProfileMenuWidget(
                          title: "Logout",
                          icon: Icons.logout,
                          textColor: Colors.red,
                          endIcon: false,
                          onPress: () {
                            showLogoutConfirmationDialog(context);
                          }),
                    ]);
                  });
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return const Text("Something went wrong");
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
