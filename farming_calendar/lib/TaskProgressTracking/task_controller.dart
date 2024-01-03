import 'package:farmtastic/TaskProgressTracking/task.dart';
import 'package:get/get.dart';

import '../Database/task_database_helper.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var taskList = <Crop>[].obs;

  Future<int> addTask({Crop? task}) async {
    return await DBHelper.insert(task);
  }

  // Get all data from the table
  void getTasks() async {
    try {
      List<Map<String, dynamic>> tasks = await DBHelper.query();
      taskList.assignAll(tasks.map((data) => new Crop.fromJson(data)).toList());
    } catch (error) {
      print("Error fetching tasks: $error");
    }
  }

  void delete(Crop task) {
    DBHelper.delete(task);
    getTasks();
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
