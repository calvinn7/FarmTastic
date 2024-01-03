// import 'package:farmtastic/calendar_model.dart';
// import 'package:farmtastic/clean_calendar_controller.dart';
// import 'package:farmtastic/CropScheduling/crop_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
// import 'package:farmtastic/scrollable_calendar.dart';
// import 'package:scrollable_clean_calendar/utils/enums.dart';
//
// class CropScheduling extends StatefulWidget {
//   @override
//   _CropSchedulingState createState() => _CropSchedulingState();
// }
//
// class _CropSchedulingState extends State<CropScheduling> {
//   String cropName = '';
//   int duration = 30; // Default duration in days
//   Color selectedColor = const Color(0xFF8A9D5F);
//   TextEditingController _start = TextEditingController();
//   TextEditingController _end = TextEditingController();
//
//   final calendarController = CleanCalendarController(
//     minDate: DateTime.now(),
//     maxDate: DateTime.now().add(
//       const Duration(days: 733),
//     ),
//     weekdayStart: DateTime.monday,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     // Listen to first and second date then update to text controller
//     _start.text = DateFormat.yMd()
//         .format(Provider.of<CalendarModel>(context, listen: true).firstDate);
//     _end.text = DateFormat.yMd()
//         .format(Provider.of<CalendarModel>(context, listen: true).secondDate);
//
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("CROP SCHEDULING"),
//           backgroundColor: const Color(0xFFF9FFDF),
//           centerTitle: true,
//           titleTextStyle: const TextStyle(
//             color: Color(0xFF567D01),
//             fontSize: 20.0, // Set the text size
//             fontWeight: FontWeight.w900, // Set the font weight
//           ),
//         ),
//         body: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10.0),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFDDECCB),
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               margin: const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
//               height: 190.0,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       const Text('Plant:'),
//                       const SizedBox(width: 30),
//                       const SizedBox(height: 20),
//                       Container(
//                         width: 150.0,
//                         height: 45.0,
//                         child: TextField(
//                           decoration: InputDecoration(
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide.none,
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide.none,
//                               borderRadius: BorderRadius.circular(25),
//                             ),
//                             filled: true,
//                             fillColor: Color(0xFF8A9D5F),
//                             border: InputBorder.none,
//                             contentPadding: EdgeInsets.only(
//                                 left: 20.0, top: 2.0, bottom: 5.0),
//                           ),
//                           onChanged: (value) {
//                             setState(() {
//                               cropName = value;
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       const Text('Duration:'),
//                       const SizedBox(width: 9),
//                       Container(
//                         margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
//                         padding: const EdgeInsets.only(left: 10),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: const Color(0xFF567D01),
//                           ),
//                           borderRadius: BorderRadius.circular(3.0),
//                         ),
//                         child: DropdownButton<int>(
//                           value: duration,
//                           items: List.generate(
//                             30,
//                             (index) => DropdownMenuItem<int>(
//                               value: index + 1,
//                               child: Text('${index + 1} days'),
//                             ),
//                           ),
//                           onChanged: (value){
//                             setState(() {
//                               duration = value!;
//                             });
//                           }
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       const Text('Color:'),
//                       const SizedBox(width: 29),
//                       ElevatedButton(
//                         onPressed: () async {
//                           Color? pickedColor = await showDialog(
//                             context: context,
//                             builder: (context) => ColorPickerDialog(),
//                           );
//                           if (pickedColor != null) {
//                             setState(() {
//                               selectedColor = pickedColor;
//                             });
//                           }
//                         },
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all<Color>(
//                               Colors.transparent),
//                           // Set the button color
//                           shape:
//                               MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(4.0),
//                               side: const BorderSide(
//                                 color: Color(0xFF567D01),
//                               ),
//                             ),
//                           ),
//                           foregroundColor:
//                               MaterialStateProperty.all<Color>(Colors.black),
//                           // Set the text color
//                           minimumSize: MaterialStateProperty.all<Size>(
//                               const Size(110, 50)),
//                           padding:
//                               MaterialStateProperty.all<EdgeInsetsGeometry>(
//                                   const EdgeInsets.only(top: 3.0)),
//                           textStyle: MaterialStateProperty.all<TextStyle>(
//                             const TextStyle(
//                               fontSize: 15.0,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                         child: const Text('Select Color'),
//                       ),
//                       const SizedBox(height: 16),
//                       const SizedBox(width: 110.0),
//                       Container(
//                         decoration: BoxDecoration(
//                           shape: BoxShape.rectangle,
//                           borderRadius: BorderRadius.circular(15.0),
//                           color: Colors.lightGreen,
//                         ),
//                         margin: const EdgeInsets.only(top: 1.0, left: 5.0),
//                         // child: SizedBox(
//                         //   width: 40.0,
//                         //   height: 40.0,
//                         //   child: IconButton(
//                         //     onPressed: () {
//                         //       // Implement scheduling logic (save crop details, update calendar, etc.)
//                         //       ScaffoldMessenger.of(context).showSnackBar(
//                         //         const SnackBar(
//                         //           content: Text("Crop is scheduled"),
//                         //         ),
//                         //       );
//                         //     },
//                         //     icon: const Icon(Icons.done),
//                         //   ),
//                         // ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(10.0),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFDDECCB),
//                   borderRadius: BorderRadius.circular(20.0),
//                 ),
//                 margin:
//                     const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
//                 height: 300.0,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: <Widget>[
//                         Expanded(
//                           child: TextFormField(
//                             readOnly: true,
//                             controller: _start,
//                             decoration: const InputDecoration(
//                               border: OutlineInputBorder(),
//                               labelText: 'Start Date',
//                             ),
//                             onTap: () => Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                     builder: (_) => CropScheduling())),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 5.0,
//                         ),
//                         Expanded(
//                           child: TextFormField(
//                             readOnly: true,
//                             controller: _end,
//                             decoration: const InputDecoration(
//                                 border: OutlineInputBorder(),
//                                 labelText: 'End Date'),
//                             onTap: () => Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                     builder: (_) => CropScheduling())),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height:
//                           10.0, // Add some space between text fields and calendar
//                     ),
//                     Expanded(
//                       child: ScrollableCleanCalendar(
//                         calendarController: calendarController,
//                         layout: Layout.DEFAULT,
//                         calendarCrossAxisSpacing: 10,
//                         calendarMainAxisSpacing: 10,
//
//                         // Use monthBuilder to customize the appearance for each month
//                         monthBuilder: (context, month) {
//                           return Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                             child: Center(
//                               child: Text(month),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//           ],
//         ),
//         // Create a button to trigger the crop schedule
//         floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
//         floatingActionButton: Padding(
//           padding: EdgeInsets.only(top: 78.0, right: 10.0),
//           child: Consumer<CalendarModel>(
//             // Press this button to pass selected date range to main page
//             builder: ((context, calendar, child) {
//               return FloatingActionButton(
//                 onPressed: () {
//                   // Check if crop name is filled and start date is selected
//                   if (cropName.isEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("Please fill in the crop name"),
//                       ),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("Crop is scheduled"),
//                       ),
//                     );
//                     // Pass selected date and notify all levels of the app using provider
//                     calendar.getDateRange(
//                       calendarController.rangeMinDate!,
//                       calendarController.rangeMaxDate!,
//                     );
//                     Navigator.of(context).pop();
//                   }
//                 },
//                 backgroundColor: Colors.lightGreen,
//                 mini: true,
//                 child: const Icon(Icons.done),
//               );
//             }),
//           ),
//         ));
//   }
// }
//
// class ColorPickerDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Pick a Color'),
//       content: SingleChildScrollView(
//         child: ColorPicker(
//           pickerColor: Colors.green,
//           onColorChanged: (color) {
//             // Handle color changes
//           },
//           showLabel: true,
//           pickerAreaHeightPercent: 0.8,
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Done'),
//         ),
//       ],
//     );
//   }
// }
