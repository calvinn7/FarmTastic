import 'package:farmtastic/Crop/crop_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../theme.dart';
import 'crop.dart';
import 'crop_tile.dart';

class ViewMySchedule extends StatefulWidget {
  @override
  _ViewMyScheduleState createState() => _ViewMyScheduleState();
}

class _ViewMyScheduleState extends State<ViewMySchedule> {
  final _cropController = Get.put(CropController());

  @override
  void initState() {
    super.initState();
    _cropController.getCrops();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          SizedBox(height: 10,),
          _showCrops(),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      title: const Text("My Schedule"),
      backgroundColor: const Color(0xFFF9FFDF),
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Color(0xFF567D01),
        fontSize: 20.0, // Set the text size
        fontWeight: FontWeight.w900, // Set the font weight
      ),
    );
  }

  _showCrops() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _cropController.cropList.length,
            itemBuilder: (_, index) {
              Crop crop = _cropController.cropList[index];
              print(crop.toJson());

              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                _showBottomSheet(context, crop);
                              },
                              child: CropTile(crop))
                        ],
                      ),
                    ),
                  ));
        });
      }),
    );
  }

  _showBottomSheet(BuildContext context, Crop crop) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(top: 2),
            height: MediaQuery.of(context).size.height * 0.22,
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
                _bottomSheetButton(
                  label: "Delete Task",
                  onTap: () {
                    _cropController.delete(crop);
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
//7.51
// _showTasks() {
//   return Expanded(
//     child: Obx(() {
//       return ListView.builder(
//           itemCount: _cropController.cropList.length,
//           itemBuilder: (_, index) {
//             Crop crop = _cropController.cropList[index];
//             print(crop.toJson());
//             // if (crop.date == DateFormat.yMd().format(selectedDay)) {
//             //   DateTime date =
//             //   DateFormat("h:mm a").parse(crop.startTime.toString());
//             //   String myTime = DateFormat("HH:mm").format(date);
//             //   print(myTime);
//             //   notifyHelper.scheduledNotification(
//             //       int.parse(myTime.split(":")[0]),
//             //       int.parse(myTime.split(":")[1]),
//             //       crop);
//
//               // DateTime date = DateFormat.jm().parse(crop.startTime.toString());
//               // var myTime = DateFormat("HH:mm").format(date);
//               // print(myTime);
//
//               return AnimationConfiguration.staggeredList(
//                   position: index,
//                   child: SlideAnimation(
//                     child: FadeInAnimation(
//                       child: Row(
//                         children: [
//                           GestureDetector(
//                               onTap: () {
//                                 // _showBottomSheet(context, crop);
//                               },
//                               child: CropTile(crop))
//                         ],
//                       ),
//                     ),
//                   ));
//             } else {
//               return Container();
//             }
//           });
//     }),
//   );
// }
}
