import 'package:farmtastic/Crop/crop.dart';
import 'package:get/get.dart';

import '../Database/task_database_helper.dart';

class CropController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var cropList = <Crop>[].obs;

  // Future<int> addCrop({Crop? crop}) async {
  //   return await DBHelper.insert(crop);
  // }

  // Get all data from the table
  void getCrops() async {
    try {
      List<Map<String, dynamic>> tasks = await DBHelper.query();
      cropList.assignAll(tasks.map((data) => new Crop.fromJson(data)).toList());
    } catch (error) {
      print("Error fetching tasks: $error");
    }
  }

  // void delete(Crop crop) {
  //   DBHelper.delete(crop);
  //   getCrops();
  // }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getCrops();
  }
}
