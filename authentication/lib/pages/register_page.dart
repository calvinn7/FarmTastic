import 'package:farmtastic/authentication/components/my_button.dart';
import 'package:farmtastic/authentication/components/my_textfield.dart';
import 'package:farmtastic/authentication/components/square_tile.dart';
import 'package:farmtastic/authentication/repository/authentication_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../main/home.dart';
import '../features/user_model.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final userRepo = Get.put(UserRepository());

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void signUserUp() async {
    BuildContext currentContext = context;
    // Show loading circle
    showDialog(
      context: currentContext,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      // Check if password is confirmed
      if (_key.currentState!.validate()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        final user = UserModel(
          email: emailController.text.trim(),
          fullName: "User",
          phoneNo: null,
          profilePicture: null,
        );

        createUser(user);
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();

        // Navigate to the profile page and replace the current screen
        Navigator.pushReplacement(
          currentContext,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        // Password not confirmed, show error message
        Navigator.of(currentContext).pop();
        showErrorMessage("An error occurred. Please try again.");
      }
    } on FirebaseAuthException catch (e) {
      // FirebaseAuthException occurred, show error message
      if (mounted) Navigator.of(currentContext).pop();
      showErrorMessage(_mapFirebaseErrorCode(e.code));
    } catch (e) {
      // Other exceptions occurred, show generic error message
      if (mounted) Navigator.of(currentContext).pop();
      showErrorMessage('An error occurred. Please try again.');
    }
  }

  // Helper function to map Firebase error codes to user-friendly messages
  String _mapFirebaseErrorCode(String code) {
    switch (code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  // Show error message in a dialog
  void showErrorMessage(String message) {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.lightGreen,
            title: const Text('Error'),
            content: Text(message),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFADBC8D),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Form(
              key: _key,
              child: Center(
                // child: ListView(
                // keyboardDismissBehavior:
                // ScrollViewKeyboardDismissBehavior.onDrag,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 25),

                      // logo
                      const Image(
                        image: AssetImage('assets/images/logo.png'),
                        width: 125.0,
                        height: 125,
                      ),

                      const SizedBox(height: 15),

                      const Center(
                        child: Text(
                          'FARMTASTIC',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // email textfield
                      MyTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                        icon: Iconsax.user,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an Email';
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return 'Please enter a valid Email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // Handle the saved value
                          emailController.text = value;
                        },
                      ),

                      const SizedBox(height: 10),

                      // password textfield
                      MyTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscureText: true,
                        icon: Iconsax.key,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid Password (Min 8 chars, Mix of'
                                '\nuppercase, lowercase, numbers, and symbols)';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // Handle the saved value
                          passwordController.text = value;
                        },
                      ),

                      const SizedBox(height: 10),

                      // confirm password textfield
                      MyTextField(
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
                        obscureText: true,
                        icon: Iconsax.key1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please re-enter password';
                          }
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // Handle the saved value
                          confirmPasswordController.text = value;
                        },
                      ),

                      const SizedBox(height: 25),

                      // sign in button
                      MyButton(
                        text: "Sign Up",
                        onTap: signUserUp,
                      ),

                      const SizedBox(height: 25),

                      // or continue with
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'Or',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),

                      // google sign in buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // google button
                          SquareTile(
                              labelText: 'Sign in with Google',
                              onTap: () async {
                                await AuthService().signInWithGoogle(context);
                              },
                              imagePath: 'assets/images/google.png'),

                          // const SizedBox(width: 25),
                          // apple button
                          // SquareTile(onTap: () {}, imagePath: 'lib/images/apple.png')
                        ],
                      ),

                      const SizedBox(height: 25),

                      // not a member? register now
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              'Login now',
                              style: TextStyle(
                                color: Colors.lightBlue[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                    // ),
                    // ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
