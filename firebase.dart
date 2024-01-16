// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtastic/authentication/features/profile_controller.dart';
import 'package:get/get.dart';

class FirebaseService {
  static FirebaseService instance = FirebaseService._privateConstructor();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseService._privateConstructor();

  Future<void> createData(
    double emissions, DateTime currentDate, DateTime selectedDate) async {
    ProfileController controller = Get.put(ProfileController());
    await controller.getUserData();
    CollectionReference carbonEmissionsCollection = firestore
        .collection('Users')
        .doc(controller.userData.value!.id)
        .collection('carbon_emissions');

    await carbonEmissionsCollection.add({
      'emissions': emissions,
      'currentDate': currentDate.toIso8601String(),
      'selectedDate': selectedDate.toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getSelectedDateEmissionsF(
      DateTime date) async {
    ProfileController controller = Get.find<ProfileController>();
    QuerySnapshot snapshot = await firestore
        .collection('Users')
        .doc(controller.userData.value!.id)
        .collection('carbon_emissions')
        .where('selectedDate', isEqualTo: date.toIso8601String())
        .get();

    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['docId'] = doc.id; // Include the document ID in the data
      return data;
    }).toList();
  }

  Future<void> deleteSelectedDateEmissionF(String docId) async {
    ProfileController controller = Get.find<ProfileController>();
    await firestore
        .collection('Users')
        .doc(controller.userData.value!.id)
        .collection('carbon_emissions')
        .doc(docId)
        .delete();
  }

  Future<List<Map<String, dynamic>>> getEmissionsF() async {
    ProfileController controller = Get.find<ProfileController>();
    QuerySnapshot snapshot = await firestore
        .collection('Users')
        .doc(controller.userData.value!.id)
        .collection('carbon_emissions')
        .orderBy('currentDate', descending: true)
        .get();

    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['docId'] = doc.id; // Include the document ID in the data
      return data;
    }).toList();
  }
  //
}
