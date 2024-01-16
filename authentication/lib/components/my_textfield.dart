import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final IconData icon;
  final String? Function(String?) validator;
  final void Function(String) onSaved;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.icon,
    required this.validator,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        onSaved: (value) => onSaved(value ?? ''),
        decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: Colors.black,
              size: 18,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(80),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.grey.shade700),
              borderRadius: BorderRadius.circular(80),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.red), // Set the error border color
              borderRadius: BorderRadius.circular(80),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 2, color: Colors.red),
              borderRadius: BorderRadius.circular(80),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}
