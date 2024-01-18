import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtastic/calendar/Crop/crop.dart';
import 'package:get/get.dart';

import '../../authentication/features/profile_controller.dart';

class CropController extends GetxController {
  static CropController get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  late ProfileController controller;

  @override
  void onReady() {
    super.onReady();
    controller = Get.put(ProfileController());
    controller.getUserData();
  }

  var cropList = <Crop>[].obs;

  Future<void> addCrop(Crop crop) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(ProfileController.instance.userData.value!.id)
          .collection('crops')
          .add(crop.toJson());

      // Update the local task list after adding the task
      await getCrops();
      print("Crop id is ${crop.id}");
    } catch (e) {
      print(e);
    }
  }
  Future<void> initializeControllerAndGetUserData() async {
    controller = Get.put(ProfileController());
    await controller.getUserData(); // Fetch user data here
  }
  Future<List<Crop>> getCrops() async {
    await initializeControllerAndGetUserData();
    final querySnapshot = await _db
        .collection('Users')
        .doc(controller.userData.value!.id)
        .collection('crops')
        .get();

    return querySnapshot.docs.map((e) => Crop.fromJson(e)).toList();

  }

  Future<void> deleteCrop(String docId) async {
    try {
      // Use the taskId to reference the specific document in the 'tasks' collection
      await _db
          .collection('Users')
          .doc(controller.userData.value!.id)
          .collection('crops')
          .doc(docId)
          .delete();
      await getCrops();
    } catch (error) {
      print("Error deleting crop: $error");
    }
  }
  // Future<int> addCrop({Crop? crop}) async {
  //   return await DbHelper.insert(crop);
  // }
  // // Get all data from the table
  // void getCrops() async {
  //   try {
  //     List<Map<String, dynamic>> crops = await DbHelper.query();
  //     cropList.assignAll(crops.map((data) => Crop.fromJson(data)).toList());
  //   } catch (error) {
  //     print("Error fetching crop: $error");
  //   }
  // }
  //
  // void delete(Crop crop) {
  //   DbHelper.delete(crop);
  //   getCrops();
  // }
}
