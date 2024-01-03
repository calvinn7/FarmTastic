import 'package:farmtastic/Crop/crop.dart';
import 'package:get/get.dart';

import '../Database/crop_database_helper.dart';

class CropController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var cropList = <Crop>[].obs;

  Future<int> addCrop({Crop? crop}) async {
    return await DbHelper.insert(crop);
  }

  // Get all data from the table
  void getCrops() async {
    try {
      List<Map<String, dynamic>> crops = await DbHelper.query();
      cropList.assignAll(crops.map((data) => new Crop.fromJson(data)).toList());
    } catch (error) {
      print("Error fetching crop: $error");
    }
  }

  void delete(Crop crop) {
    DbHelper.delete(crop);
    getCrops();
  }

  // void markTaskCompleted(int id) async {
  //   await DbHelper.update(id);
  //   getCrops();
  // }
}
