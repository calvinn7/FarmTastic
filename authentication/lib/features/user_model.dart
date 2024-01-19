import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNo;
  final String? profilePicture;

  const UserModel({
    this.id,
    required this.email,
    required this.fullName,
    required this.phoneNo,
    required this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "ProfilePicture": profilePicture,
    };
  }

  factory UserModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return UserModel(
      id: document.id,
      email: data?["Email"],
      fullName: data?["FullName"],
      phoneNo: data?["Phone"],
      profilePicture: data?["ProfilePicture"],
    );
  }
}
