import 'package:farmtastic/authentication/features/profile_controller.dart';
import 'package:farmtastic/authentication/features/user_model.dart';
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

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProfileController()); // Initialize the controller
  }

  @override
  Widget build(BuildContext context) {
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
                    return Column(children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipOval(
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
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    UserModel? user = controller.userData.value;
                                    final userData = UserModel(
                                        id: id.text,
                                        email: email.text.trim(),
                                        fullName: fullName.text.trim(),
                                        phoneNo: phoneNo.text.trim(),
                                        profilePicture: user?.profilePicture);

                                    await controller.updateRecord(
                                        userData, context);
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
                                  ElevatedButton(
                                    onPressed: () {
                                      UserModel? user =
                                          controller.userData.value;
                                      final userData = UserModel(
                                          id: id.text,
                                          email: email.text.trim(),
                                          fullName: fullName.text.trim(),
                                          phoneNo: phoneNo.text.trim(),
                                          profilePicture: user?.profilePicture);
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
                                                        emailController.text.trim();
                                                    String password =
                                                        passwordController.text.trim();
                                                    try {
                                                      await controller
                                                          .deleteAccount(userData,email,
                                                              password,context);
                                                    } catch (error) {
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                      scaffoldMessenger
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: Text('$error'),
                                                        duration:
                                                            const Duration(
                                                                seconds: 3),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ));
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
}
