import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtastic/authentication/features/user_model.dart';
import 'package:farmtastic/authentication/repository/authentication_repository/user_repository.dart';
import 'package:farmtastic/main/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //Google Sign in
  signInWithGoogle(BuildContext context) async {
    //begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    //create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    final _db = FirebaseFirestore.instance;
    final userRepo = Get.put(UserRepository());

    try {
      // finally, let's sign in
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      // Access the authenticated user
      final User user = authResult.user!;
      for (final providerProfile in user.providerData) {

        final UserModel userModel = UserModel(
            email: user.email!,
            fullName: providerProfile.displayName ?? "User",
            phoneNo: null,
            profilePicture: providerProfile.photoURL!);

        // Check if the user exists in Firestore
        final userSnapshot = await _db
            .collection("Users")
            .where("Email", isEqualTo: user.email)
            .get();

        if (userSnapshot.docs.isEmpty) {
          // User doesn't exist in Firestore, create a new user record
          // final UserModel userModel = UserModel(
          //   email: user.email!,
          //   fullName: user.displayName ?? "User",
          //   phoneNo: null,
          //   profilePicture:
          // );
          await userRepo.createUser(userModel);
        }
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Home()), // Replace YourHomePage with the actual home page class
      );
    } catch (e) {
      // Handle sign-in error
      print("Error signing in with Google: $e");
    }
  }
}
