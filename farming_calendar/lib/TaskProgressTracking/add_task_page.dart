import 'package:farmtastic/calendar/TaskProgressTracking/task.dart';
import 'package:farmtastic/calendar/TaskProgressTracking/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../services/inputText.dart';
import '../services/theme.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _endTime = "9.30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                title: "Title",
                hint: "Enter task title",
                controller: _titleController,
              ),
              MyTextField(
                title: "Note",
                hint: "Enter note",
                controller: _noteController,
              ),
              MyTextField(
                  title: "Date",
                  hint: DateFormat.yMd().format(_selectedDate),
                  widget: IconButton(
                    icon: const Icon(Icons.calendar_today_outlined),
                    onPressed: () {
                      _getDateFromUser();
                    },
                  )),
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      title: "Start Time",
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: MyTextField(
                      title: "End Time",
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              MyTextField(
                title: "Remind",
                hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subTitleStyle,
                  underline: Container(height: 0),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.lightGreen,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          // Set the shadow color
                          spreadRadius: 2,
                          // Set the spread radius of the shadow
                          blurRadius: 5,
                          // Set the blur radius of the shadow
                          offset: const Offset(0, 3), // Set the offset of the shadow
                        ),
                      ],
                    ),
                    margin: const EdgeInsets.only(top: 100.0, left: 310.0),
                    child: SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: IconButton(
                        onPressed: () {
                          _validateDate();
                        },
                        icon: const Icon(Icons.done),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _validateDate() {
    if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All fields are required!"),
        ),
      );
    } else if (_titleController.text.isNotEmpty &&
        _noteController.text.isNotEmpty) {
      DateTime dateWithoutTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day);

      final task = Task(
          note: _noteController.text,
          title: _titleController.text,
          date: dateWithoutTime.toIso8601String(),
          startTime: _startTime,
          endTime: _endTime,
          remind: _selectedRemind,
          isCompleted: false);
      _taskController.addTask(task);
      Navigator.of(context).pop();
    }
  }

  // Future<void> _addTaskToFirestore() async {
  //   try {
  //     CollectionReference tasks = FirebaseFirestore.instance
  //         .collection('Users')
  //         .doc(ProfileController.instance.userData.value!.id)
  //         .collection('tasks');
  //
  //     await tasks.add({
  //       'note': _noteController.text,
  //       'title': _titleController.text,
  //       'date': DateFormat.yMd().format(_selectedDate),
  //       'startTime': _startTime,
  //       'endTime': _endTime,
  //       'remind': _selectedRemind,
  //       'isCompleted': false,
  //     });
  //
  //     print("Task added to Firestore successfully");
  //   } catch (e) {
  //     print("Error adding task to Firestore: $e");
  //   }
  // }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2040),
    );
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("it is null or something is wrong");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time canceled");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));
  }

  _appBar() {
    return AppBar(
      title: const Text("Add Task"),
      backgroundColor: const Color(0xFFF9FFDF),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Color(0xFF567D01),
        fontSize: 20.0, // Set the text size
        fontWeight: FontWeight.w900, // Set the font weight
      ),
    );
  }
}
