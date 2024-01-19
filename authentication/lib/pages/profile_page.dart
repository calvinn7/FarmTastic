import 'package:farmtastic/authentication/features/profile_controller.dart';
import 'package:farmtastic/authentication/pages/about_app_page.dart';
import 'package:farmtastic/authentication/pages/login_or_register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../main/sidebar.dart';
import '../features/profile_menu.dart';
import '../features/user_model.dart';
import 'auth_page.dart';
import 'update_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Sign user out method
  void signUserOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pop(); // Close the profile page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AuthPage(),
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
    return Scaffold(
      backgroundColor: const Color(0xFFF9FFDF),
      drawer: Sidebar(),
      appBar: AppBar(
        backgroundColor: Color(0xFFF9FFDF),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            width: double.infinity,
            height: 0.7,
            color: Colors.grey, // Choose your line color
          ),
        ),
        title: const Text('Profile'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Color(0xFF567D01),

          fontSize: 24.0, // Set the text size

          fontWeight: FontWeight.w900, // Set the font weight
        ),

      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Builder(builder: (context) {
                    return Column(children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipOval(
                              child: Obx(() {
                                UserModel? userData = ProfileController.instance.userData.value;

                                if (userData != null) {
                                  // Update UI with user profile picture
                                  return userData.profilePicture != null
                                      ? Image.network(
                                    userData.profilePicture!,
                                    fit: BoxFit.cover,
                                  )
                                      : Image.asset(
                                    'assets/images/sheep.png',
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  // Handle case where user data is null
                                  return const CircularProgressIndicator();
                                }
                              }),
                            ),
                          ),
                      const SizedBox(height: 10),
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
                      }),
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
                          title: "FAQ",
                          icon: LineAwesomeIcons.question,
                          onPress: () {
                          }),
                      ProfileMenuWidget(
                          title: "Feedback",
                          icon: LineAwesomeIcons.edit,
                          onPress: () {}),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ProfileMenuWidget(
                          title: "About App",
                          icon: LineAwesomeIcons.info,
                          onPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const AboutAppPage();
                                },
                              ),
                            );
                          }),
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
