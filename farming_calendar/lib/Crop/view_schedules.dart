import 'package:farmtastic/Crop/crop_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewMySchedule extends StatefulWidget {
  @override
  _ViewMyScheduleState createState() => _ViewMyScheduleState();
}

class _ViewMyScheduleState extends State<ViewMySchedule> {
 final _cropController = Get.put(CropController());

 @override
  void initState(){
   super.initState();
   _cropController.getCrops();
 }

 @override
  Widget build(BuildContext context){
   return Scaffold(
     appBar: _appBar(),
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
}

