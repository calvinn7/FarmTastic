import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/theme.dart';
import 'crop.dart';

class CropTile extends StatelessWidget {
  final Crop? crop;

  CropTile(this.crop);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: const EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(crop?.color ?? 0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Set the shadow color
              spreadRadius: 3, // Set the spread radius of the shadow
              blurRadius: 5, // Set the blur radius of the shadow
              offset: const Offset(0, 3), // Set the offset of the shadow
            ),
          ],
        ),

        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  crop?.plant ?? "",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.black38,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "${crop!.startDate} - ${crop!.endDate}",
                      style: GoogleFonts.lato(
                        textStyle:
                            const TextStyle(fontSize: 13, color: Colors.black38),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return c1;
      case 1:
        return c2;
      case 2:
        return c3;
      case 3:
        return c4;
      default:
        return c1;
    }
  }
}
