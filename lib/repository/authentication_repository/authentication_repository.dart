import 'package:farmtastic/pages/login_or_register_page.dart';
import 'package:farmtastic/pages/login_page.dart';
import 'package:farmtastic/pages/register_page.dart';
import 'package:farmtastic/repository/authentication_repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../pages/profile/profile_page.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  // String? get user => firebaseUser.value?.email;

  // @override
  // void onReady() {
  //   firebaseUser = Rx<User?>(_auth.currentUser);
  //   firebaseUser.bindStream(_auth.userChanges());
  //   ever(firebaseUser, _setInitialScreen);
  // }
  @override
  void onInit() {
    // Initialize the firebaseUser variable here
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    // ever(firebaseUser, _setInitialScreen);
    super.onInit();
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const ProfilePage())
        : Get.offAll(() => const LoginOrRegisterPage());
  }

  // void deleteUserAccount(UserModel user) async {
  //   User user = await _auth.currentUser;

  //   user.delete().then((res) {
  //     Get.offAll(LoginPage);
  //     Get.snackbar("User Account Deleted", "Success");
  //   } );
  // }
}
