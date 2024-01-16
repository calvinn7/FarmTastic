import 'package:farmtastic/authentication/features/profile_controller.dart';
import 'package:farmtastic/authentication/features/user_model.dart';
import 'package:farmtastic/authentication/pages/login_or_register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late ProfileController controller; // Declare the controller
  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProfileController()); // Initialize the controller
  }

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ProfileController());
    // final ProfileController controller = Get.find();
    return Scaffold(
      backgroundColor: const Color(0xFFF9FFDF),

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
        title: Text('Profile'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Color(0xFF567D01),

          fontSize: 24.0, // Set the text size

          fontWeight: FontWeight.w900, // Set the font weight
        ),
      ),
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: () => Get.back(),
      //       icon: const Icon(LineAwesomeIcons.angle_left)),
      //   title: Text('sds', style: Theme.of(context).textTheme.headlineMedium),
      // ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel userData = snapshot.data as UserModel;
                    final id = TextEditingController(text: userData.id);
                    //Controllers
                    final email = TextEditingController(text: userData.email);
                    final fullName =
                        TextEditingController(text: userData.fullName);
                    final phoneNo =
                        TextEditingController(text: userData.phoneNo);
                    /* return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (c, index) {
                        return Column(
                          children: [
                            ListTile(
                              iconColor: Colors.blue,
                              tileColor: Colors.blue.withOpacity(0.1),
                              leading: const Icon(LineAwesomeIcons.user_1),
                              title: Text(
                                  "Name: ${snapshot.data![index].fullName}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "phoneNo: ${snapshot.data![index].phoneNo}"),
                                  Text("email: ${snapshot.data![index].email}"),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    );
                    */
                    return Column(children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                              child: userData.profilePicture != null
                                  ? Image.network(
                                userData.profilePicture!,
                                fit: BoxFit.cover,
                              )
                                  : Image.asset(
                                'assets/images/sheep.png',
                                fit: BoxFit.cover,
                              ),

                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
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
                      const SizedBox(
                        height: 50,
                      ),
                      Form(
                          key: _key,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: fullName,
                                // initialValue: userData.fullName,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.black),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(80),
                                        borderSide: const BorderSide(
                                            width: 2, color: Colors.black)),
                                    label: const Text('Full Name'),
                                    prefixIcon:
                                        const Icon(LineAwesomeIcons.user)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: phoneNo,
                                // initialValue: userData.phoneNo,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.black),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(80),
                                        borderSide: const BorderSide(
                                            width: 2, color: Colors.black)),
                                    label: const Text('Phone No'),
                                    prefixIcon:
                                        const Icon(LineAwesomeIcons.phone)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                readOnly: true,
                                // controller: email,
                                initialValue: userData.email,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    floatingLabelStyle:
                                        const TextStyle(color: Colors.black),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(80),
                                        borderSide: const BorderSide(
                                            width: 0.7, color: Colors.black)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(80),
                                        borderSide: const BorderSide(
                                            width: 0.7, color: Colors.black)),
                                    label: const Text('E-Mail'),
                                    prefixIcon: const Icon(
                                        LineAwesomeIcons.envelope_1)),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // TextFormField(
                              //   controller: password,
                              //   // initialValue: userData.password,
                              //   obscureText: _isObsecure,
                              //   decoration: InputDecoration(
                              //     border: OutlineInputBorder(
                              //       borderRadius: BorderRadius.circular(80),
                              //     ),
                              //     floatingLabelStyle:
                              //         const TextStyle(color: Colors.black),
                              //     focusedBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(80),
                              //         borderSide: const BorderSide(
                              //             width: 2, color: Colors.black)),
                              //     label: const Text('Password'),
                              //     prefixIcon: const Icon(LineAwesomeIcons.lock),
                              //     suffixIcon: IconButton(
                              //       onPressed: () {
                              //         setState(() {
                              //           _isObsecure = !_isObsecure;
                              //         });
                              //       },
                              //       icon: _isObsecure
                              //           ? const Icon(Icons.visibility)
                              //           : const Icon(Icons.visibility_off),
                              //       color: Colors.grey,
                              //     ),
                              //   ),
                              // ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    final userData = UserModel(
                                        id: id.text,
                                        email: email.text.trim(),
                                        fullName: fullName.text.trim(),
                                        phoneNo: phoneNo.text.trim(),
                                        profilePicture:
                                            null);

                                    // Map<String, dynamic> details = {
                                    //   'FullName': fullName,
                                    //   'Email': email,
                                    //   'Phone': phoneNo
                                    // };
                                    await controller.updateRecord(
                                        userData, context);
                                    // await controller.getUserData();
                                    // Indicate success and close the page
                                    Navigator.pop(context, true);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green[200],
                                      side: BorderSide.none,
                                      shape: const StadiumBorder()),
                                  child: const Text(
                                    'Update Profile',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // const Text.rich(TextSpan(
                                  //     text: 'Joined ',
                                  //     style: TextStyle(fontSize: 12),
                                  //     children: [
                                  //       TextSpan(
                                  //           text: '12 December 2023',
                                  //           style: TextStyle(
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 12))
                                  //     ])),
                                  ElevatedButton(
                                    onPressed: () {
                                      final userData = UserModel(
                                          id: id.text,
                                          email: email.text.trim(),
                                          fullName: fullName.text.trim(),
                                          phoneNo: phoneNo.text.trim(),
                                          profilePicture:
                                              null);
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          final GlobalKey<FormState>
                                              alertDialogKey =
                                              GlobalKey<FormState>();
                                          final ScaffoldMessengerState
                                              scaffoldMessenger =
                                              ScaffoldMessenger.of(context);
                                          return AlertDialog(
                                            title:
                                                const Text('Enter Credentials'),
                                            content: Form(
                                              key: alertDialogKey,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter an Email';
                                                      }
                                                      if (!RegExp(
                                                              "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                                          .hasMatch(value)) {
                                                        return 'Please enter a valid Email';
                                                      }
                                                      return null;
                                                    },
                                                    controller: emailController,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText: 'Email'),
                                                  ),
                                                  TextFormField(
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter a password';
                                                      }
                                                      return null;
                                                    },
                                                    controller:
                                                        passwordController,
                                                    obscureText: true,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Password'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // Close the dialog
                                                },
                                                child: const Text('Cancel'),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  if (alertDialogKey
                                                      .currentState!
                                                      .validate()) {
                                                    // The form is valid, proceed with the submission
                                                    String email =
                                                        emailController.text
                                                            .trim();
                                                    String password =
                                                        passwordController.text
                                                            .trim();
                                                    try {
                                                      await controller
                                                          .deleteAccount(
                                                              userData,
                                                              email,
                                                              password,
                                                              context);
                                                      if (mounted) {
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const LoginOrRegisterPage(),
                                                          ),
                                                        );
                                                        scaffoldMessenger
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                                'Account deleted successfully'),
                                                            backgroundColor:
                                                                Colors.green,
                                                          ),
                                                        );
                                                      }
                                                    } catch (error) {
                                                        scaffoldMessenger
                                                            .showSnackBar(
                                                          SnackBar(
                                                            content:
                                                                Text('$error'),
                                                            duration:
                                                                const Duration(
                                                                    seconds: 3),
                                                            backgroundColor:
                                                                Colors.red,
                                                          ),
                                                        );
                                                        Navigator.of(context)
                                                            .pop(); // Close the dialog
                                                        emailController.clear();
                                                        passwordController
                                                            .clear();
                                                    }
                                                  }
                                                },
                                                child: const Text('Submit'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      /*showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CredentialInputDialog(
                                          onCredentialsEntered:
                                              (email, password) async {
                                            try {
                                              await controller.deleteAccount(
                                                  userData,
                                                  email,
                                                  password,
                                                  context);
                                              if (mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Account deleted successfully'),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                              }
                                            } catch (error) {
                                              if (mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Error deleting account: $error'),
                                                    duration:
                                                        Duration(seconds: 3),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                            }
                                          },
                                        ),
                                      );
                                      */
                                      // Navigator.of(context)
                                      //     .pop(); // Close the dialog
                                      // Navigator.of(context).pushReplacement(
                                      //   MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           LoginOrRegisterPage()),
                                      // );
                                      // Navigator.of(context)
                                      //     .pushReplacement(
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //         LoginPage(onTap: () {}),
                                      //   ),
                                      // );
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.redAccent.withOpacity(0.1),
                                        elevation: 0,
                                        foregroundColor: Colors.red,
                                        shape: const StadiumBorder(),
                                        side: BorderSide.none),
                                    child: const Text('Delete'),
                                  )
                                ],
                              )
                            ],
                          ))
                    ]);
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
            )),
      ),
    );
  }

// Future<void> _showDeleteConfirmationDialog(
//     BuildContext context, UserModel userData) async {
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Delete Account'),
//         content: const Text('Are you sure you want to delete your account?'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop(); // Close the dialog
//             },
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               await controller.deleteAccount(userData);
//               Navigator.of(context).pop(); // Close the dialog
//               Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(
//                     builder: (context) => LoginPage(
//                           onTap: () {},
//                         )),
//               );
//             },
//             child: const Text(
//               'Delete',
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//         ],
//       );
//     },
//   );
}

//   Future<bool> _showCredentialsInputDialog(BuildContext context) async {
//     return await showDialog<bool>(
//           context: context,
//           builder: (context) => CredentialInputDialog(),
//         ) ??
//         false;
//   }

//   Future<void> _handleAccountDeletion(UserModel userData) async {
//     try {
//       await controller.deleteAccount(userData);

//       // Navigate to the login page after successful deletion
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => LoginPage(onTap: () {}),
//         ),
//       );
//     } catch (e) {
//       print('Error handling account deletion: $e');
//       // Handle the account deletion error
//     }
//   }
// }

// class _CredentialInputDialog extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _CredentialInputDialogState();
// }

// class _CredentialInputDialogState extends State<_CredentialInputDialog> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text('Enter Credentials'),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TextField(
//             controller: _emailController,
//             decoration: InputDecoration(labelText: 'Email'),
//           ),
//           TextField(
//             controller: _passwordController,
//             obscureText: true,
//             decoration: InputDecoration(labelText: 'Password'),
//           ),
//         ],
//       ),
//       actions: [
//         ElevatedButton(
//           onPressed: () {
//             Navigator.of(context).pop(false); // Close the dialog with false
//           },
//           child: Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             String email = _emailController.text.trim();
//             String password = _passwordController.text.trim();
//           },
//           child: Text('Submit'),
//         ),
//       ],
//     );
//   }
// }
