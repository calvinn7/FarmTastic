import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final String labelText;
  final Function()? onTap;

  const SquareTile({
    super.key,
    required this.imagePath,
    required this.labelText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 20,
              width: 35,
            ),
            const SizedBox(height: 8), // Adjust the spacing as needed
            Text(
              labelText,
              style: TextStyle(
                fontSize: 12, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
