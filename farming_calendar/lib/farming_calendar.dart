import 'package:farmtastic/Crop/crop_controller.dart';
import 'package:farmtastic/TaskProgressTracking/task_controller.dart';
import 'package:farmtastic/services/theme.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

import 'Crop/crop_scheduling_page.dart';
import 'Crop/view_schedules.dart';
import 'TaskProgressTracking/add_task_page.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'TaskProgressTracking/task.dart';
import 'TaskProgressTracking/task_tile.dart';
import 'TaskReminder/notification_services.dart';

class FarmingCalendar extends StatefulWidget {
  @override
  _FarmingCalendarState createState() => _FarmingCalendarState();
}

class _FarmingCalendarState extends State<FarmingCalendar> {
  late NotifyHelper notifyHelper;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  final _taskController = Get.put(TaskController());
  final _cropController = Get.put(CropController());

  @override
  void initState() {
    super.initState();
    selectedDay = DateTime.now();
    notifyHelper = NotifyHelper();
    notifyHelper.requestNotificationPermissions();
    _taskController.getTasks();
    _cropController.getCrops();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                color: const Color(0xFFDDECCB),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Set the shadow color
                    spreadRadius: 5, // Set the spread radius of the shadow
                    blurRadius: 7, // Set the blur radius of the shadow
                    offset: Offset(0, 3), // Set the offset of the shadow
                  ),
                ],
              ),
              margin: const EdgeInsets.only(
                  left: 20.0, top: 10.0, right: 20.0, bottom: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Align(
                        child: Container(
                          width: 270,
                          margin: const EdgeInsets.only(top: 10.0, left: 15.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewMySchedule()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.lightGreen),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'View My Schedule',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.lightGreen,
                          ),
                          margin: const EdgeInsets.only(top: 10.0, left: 10),
                          child: SizedBox(
                            width: 40.0,
                            height: 40.0,
                            child: IconButton(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CropSchedulingPage()),
                                );
                                _cropController.getCrops();
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TableCalendar(
                    focusedDay: selectedDay,
                    firstDay: DateTime(2022),
                    lastDay: DateTime(2030),
                    startingDayOfWeek: StartingDayOfWeek.monday,
                    daysOfWeekVisible: true,

                    //Day Changed
                    onDaySelected: (DateTime selectDay, DateTime focusDay) {
                      setState(() {
                        selectedDay = selectDay;
                        focusedDay = focusDay;
                      });
                      print(focusedDay);
                    },
                    selectedDayPredicate: (DateTime date) {
                      return isSameDay(selectedDay, date);
                    },

                    //To style the Calendar
                    calendarStyle: const CalendarStyle(
                      isTodayHighlighted: true,
                      todayDecoration: BoxDecoration(
                        color: Color(0xFF7ECBAB),
                        shape: BoxShape.circle,
                      ),
                      selectedTextStyle: TextStyle(color: Colors.black),
                      selectedDecoration: BoxDecoration(
                        color: Color(0xFFB3E8D1),
                        shape: BoxShape.circle,
                      ),
                      defaultDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      weekendDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    ),
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),

                    // Add the eventLoader property
                    eventLoader: (date) {
                      return _getEventsForDay(date);
                    },
                  ),
                ],
              )),
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 7.0),
              decoration: BoxDecoration(
                color: const Color(0xFF8A9D5F),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Set the shadow color
                    spreadRadius: 5, // Set the spread radius of the shadow
                    blurRadius: 7, // Set the blur radius of the shadow
                    offset: Offset(0, 3), // Set the offset of the shadow
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "TASK FOR THE DAY",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            selectedDay.toString().split(" ")[0],
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 180.0, // Set the desired height
                        child: Column(
                          children: [
                            _showTasks(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0.0,
                    child: Container(
                      width: 335.0,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddTaskPage()),
                          );
                          _taskController.getTasks();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(169, 180, 144, 1.0),
                          ),
                          // Set the button color
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(),
                          ),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        icon: Icon(Icons.add),
                        label: Row(
                          children: [
                            SizedBox(width: 3),
                            // Adjust the space between icon and text
                            Text("Add a task"),
                            // Your text
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<dynamic> _getEventsForDay(DateTime date) {
    // Get a list of events/tasks for the specified date
    List<dynamic> events = _taskController.taskList
        .where((task) => task.date == DateFormat.yMd().format(date))
        .toList();

    return events;
  }

  _appBar() {
    return AppBar(
      title: const Text("FARMING CALENDAR"),
      backgroundColor: const Color(0xFFF9FFDF),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          // Add your logic for handling menu button click
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            // Add your logic for handling settings button click
          },
        ),
      ],
      titleTextStyle: const TextStyle(
        color: Color(0xFF567D01),
        fontSize: 20.0, // Set the text size
        fontWeight: FontWeight.w900, // Set the font weight
      ),
    );
  }

  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              Task task = _taskController.taskList[index];
              print(task.toJson());
              if (task.date == DateFormat.yMd().format(selectedDay)) {
                DateTime date =
                    DateFormat("h:mm a").parse(task.startTime.toString());
                String myTime = DateFormat("HH:mm").format(date);
                print(myTime);
                notifyHelper.scheduledNotification(
                    int.parse(myTime.split(":")[0]),
                    int.parse(myTime.split(":")[1]),
                    task);

                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  _showBottomSheet(context, task);
                                },
                                child: TaskTile(task))
                          ],
                        ),
                      ),
                    ));
              } else {
                return Container();
              }
            });
      }),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(top: 2),
            height: task.isCompleted == 1
                ? MediaQuery.of(context).size.height * 0.22
                : MediaQuery.of(context).size.height * 0.30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                    height: 6,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[400],
                    )),
                Spacer(),
                task.isCompleted == 1
                    ? Container()
                    : _bottomSheetButton(
                        label: "Task Completed",
                        onTap: () {
                          _taskController.markTaskCompleted(task.id!);
                          Navigator.of(context).pop();
                        },
                        clr: Colors.lightGreen,
                        context: context,
                      ),
                _bottomSheetButton(
                  label: "Delete Task",
                  onTap: () {
                    _taskController.delete(task);
                    Navigator.of(context).pop();
                  },
                  clr: Colors.red[300]!,
                  context: context,
                ),
                SizedBox(
                  height: 20,
                ),
                _bottomSheetButton(
                  label: "Close",
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  clr: Colors.red[300]!,
                  isClose: true,
                  context: context,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  _bottomSheetButton({
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        height: 55,
        decoration: BoxDecoration(
          border: Border.all(
              width: 2, color: isClose == true ? Colors.grey[300]! : clr),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style:
                isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
