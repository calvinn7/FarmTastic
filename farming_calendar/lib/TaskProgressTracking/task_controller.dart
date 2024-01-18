import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmtastic/authentication/features/profile_controller.dart';
import 'package:farmtastic/calendar/TaskProgressTracking/task.dart';
import 'package:get/get.dart';


class TaskController extends GetxController {
  static TaskController get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  late ProfileController controller;

  @override
  void onReady() {
    super.onReady();
    controller = Get.put(ProfileController());
    controller.getUserData();
  }

  var taskList = <Task>[].obs;

  Future<void> addTask(Task task) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(ProfileController.instance.userData.value!.id)
          .collection('tasks')
          .add(task.toJson());

      // Update the local task list after adding the task
      await getTasks();
      print("Task added to Firestore successfully");

    } catch (e) {
      print("Error adding task to Firestore: $e");
    }
  }
  Future<void> initializeControllerAndGetUserData() async {
    controller = Get.put(ProfileController());
    await controller.getUserData(); // Fetch user data here
  }
  Future<List<Task>> getTasks() async {
    await initializeControllerAndGetUserData();
    final querySnapshot = await _db
        .collection('Users')
        .doc(controller.userData.value!.id)
        .collection('tasks')
        .get();

   return querySnapshot.docs.map((e) => Task.fromJson(e)).toList();

  }

  Future<void> deleteTask(String docId) async {
    try {
      // Use the taskId to reference the specific document in the 'tasks' collection
      await _db
          .collection('Users')
          .doc(controller.userData.value!.id)
          .collection('tasks')
          .doc(docId)
          .delete();
      await getTasks();
    } catch (error) {
      print("Error deleting task: $error");
    }
  }

  void markTaskCompleted(String docId) async {
    try {
      await _db
          .collection("Users")
          .doc(controller.userData.value!.id)
          .collection('tasks')
          .doc(docId)
          .update({'isCompleted': true});
      await getTasks();
    } catch (e) {
      print("Error updating task in Firebase: $e");
    }
  }
}
