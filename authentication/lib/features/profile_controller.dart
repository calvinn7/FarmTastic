import 'package:farmtastic/authentication/features/user_model.dart';
import 'package:farmtastic/authentication/repository/authentication_repository/authentication_repository.dart';
import 'package:farmtastic/authentication/repository/authentication_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/auth_page.dart';
import '../pages/login_or_register_page.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _userRepo = Get.put(UserRepository());
  final _authRepo = Get.put(AuthenticationRepository());
  late final Rx<User?> firebaseUser;
  late final Rx<UserModel?> userData;

  // Constructor
  ProfileController() {
    firebaseUser = _authRepo.firebaseUser;
    userData = Rx<UserModel?>(null);
  }

  getUserData() async {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      // return _userRepo.getUserDetails(email);
      final fetchedUserData = await _userRepo.getUserDetails(email);
      userData.value = fetchedUserData;
      return fetchedUserData;
    }
  }

  Future<List<UserModel>> getAllUser() async {
    return await _userRepo.allUser();
  }

  Future<void> updateRecord(UserModel user, BuildContext context) async {
    try {
      await _userRepo.updateUserRecord(user);
      await getUserData();
      userData.value = user;
      update(); // Show success snackbar
      // ScaffoldMessenger.of(context!).showSnackBar(
      //   SnackBar(
      //     content: Text('Profile updated successfully!'),
      //     duration: Duration(seconds: 3),
      //     backgroundColor: Colors.green,
      //   ),
      // );
    } catch (e) {
      // Show error snackbar
      // ScaffoldMessenger.of(context!).showSnackBar(
      //   SnackBar(
      //     content: Text('Error updating profile: $e'),
      //     duration: Duration(seconds: 3),
      //     backgroundColor: Colors.red,
      //   ),
      // );
    }
  }

  Future<void> deleteAccount(UserModel usermodel, String userEmail,
      String userPassword, BuildContext context) async {
    try {
      // Get the currently signed-in user
      final user = FirebaseAuth.instance.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(
          email: userEmail, password: userPassword);

      // Re-authenticate the user
      await user!.reauthenticateWithCredential(credential);
      await _userRepo.removeUserRecord(usermodel.id!);
      await user.delete();
      await FirebaseAuth.instance.signOut();

      print('User account deleted successfully.');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AuthPage(),
        ),
      );

      // Display a success message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting account: $e'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
      Navigator.of(context).pop();

    }
  }

  bool isUserSignedInWithGoogle(User? user) {
    if (user == null) {
      return false;
    }

    for (UserInfo userInfo in user.providerData) {
      if (userInfo.providerId == GoogleAuthProvider.PROVIDER_ID) {
        return true;
      }
    }

    return false;
  }
}
