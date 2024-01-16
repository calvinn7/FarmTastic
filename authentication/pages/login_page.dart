import 'package:farmtastic/authentication/components/my_button.dart';
import 'package:farmtastic/authentication/components/my_textfield.dart';
import 'package:farmtastic/authentication/components/square_tile.dart';
import 'package:farmtastic/authentication/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../main/home.dart';
import 'forgot_pw_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void dispose() {
    // Dispose your controllers here
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // sign user in method
  void signUserIn() async {
    BuildContext currentContext = context;
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign in
    try {
      if (_key.currentState != null && _key.currentState!.validate()) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (mounted) {
          Navigator.of(context).pop();
          Navigator.pushReplacement(
            currentContext,
            MaterialPageRoute(builder: (context) => Home()),
          );
        }
      } else {
        if (mounted) Navigator.of(context).pop();
        showErrorMessage("An error occurred. Please try again.");
      }
    } on FirebaseAuthException catch (e) {
      // Pop the loading circle
      if (mounted) Navigator.of(context).pop();

      //Wrong Email
      if (e.code == 'user-not-found') {
        // User not registered
        showErrorMessage('No user found for that email.');
      }
      //Wrong Password
      else if (e.code == 'wrong-password') {
        showErrorMessage('Wrong password provided for that user.');
      } else {
        // Other errors
        showErrorMessage(e.code);
      }
    }
  }

// Show error message in a dialog
  void showErrorMessage(String message) {
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
                // child: SingleChildScrollView(
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
                          // if (!RegExp(
                          //         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          //     .hasMatch(value)) {
                          //   return 'Please enter a correct Password';
                          // }
                          return null;
                        },
                        onSaved: (value) {
                          // Handle the saved value
                          passwordController.text = value;
                        },
                      ),

                      const SizedBox(height: 10),

                      // forgot password?
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const ForgotPasswordPage();
                                    },
                                  ),
                                );
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // sign in button
                      MyButton(
                        text: "Sign in",
                        onTap: signUserIn,
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

                      // google + apple sign in buttons
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
                            'Not a member?',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              'Register now',
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

// String? validateEmail(String? formEmail) {
//   if (formEmail == null || formEmail.isEmpty) {
//     return 'E-mail address is required.';
//   }
//   String pattern = r'\w+@\w+\.\w+';
//   RegExp regex = RegExp(pattern);
//   if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';
//   return null;
// }
//
// String? validatePassword(String? formPassword) {
//   if (formPassword == null || formPassword.isEmpty) {
//     return 'Password is required.';
//   }
//
//   String pattern =
//       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~\).{8,}$';
//   RegExp regex = RegExp(pattern);
//   if (!regex.hasMatch(formPassword)) {
//     return '''
//   Password must be at least 8 characters,
//   inclue an uppercase letter, number and symbol.
//   ''';
//   }
//   return null;
// }
