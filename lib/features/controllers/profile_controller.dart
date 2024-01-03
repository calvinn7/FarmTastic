import 'package:farmtastic/features/authentication/user_model.dart';
import 'package:farmtastic/pages/login_or_register_page.dart';
import 'package:farmtastic/repository/authentication_repository/authentication_repository.dart';
import 'package:farmtastic/repository/authentication_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

// //Controllers
//   final email = TextEditingController();
//   final password = TextEditingController();
//   final fullName = TextEditingController();
//   final phoneNo = TextEditingController();

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
    AuthCredential credential =
        EmailAuthProvider.credential(email: userEmail, password: userPassword);

    try {
      // Re-authenticate the user

      // Get the currently signed-in user
      User? user = FirebaseAuth.instance.currentUser;
      await user?.reauthenticateWithCredential(credential);

      if (user != null) {
        // Delete the user account
        await user.delete();
        await _userRepo.removeUserRecord(usermodel.id!);
        // Navigator.of(context).pushReplacement(
        //   MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
        // );
        print('User account deleted successfully.');
        // Show success snackbar
        // ScaffoldMessenger.of(context!).showSnackBar(
        //   SnackBar(
        //     content: Text('User account deleted successfully!'),
        //     duration: Duration(seconds: 3),
        //     backgroundColor: Colors.green,
        //   ),
        // );
        // Navigator.of(context!).pushReplacement(
        //   MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
        // );
      } else {
        print('No user signed in.');
        // Navigator.of(context!).pop();
      }
    } catch (e) {
      throw 'Error deleting account: $e';
      // print('Error deleting account: $e');
      // ScaffoldMessenger.of(context!).showSnackBar(
      //   SnackBar(
      //     content: Text('Error deleting account: $e'),
      //     duration: Duration(seconds: 3),
      //     backgroundColor: Colors.red,
      //   ),
      // );
      // Navigator.of(context!).pop();
    }
  }
}
