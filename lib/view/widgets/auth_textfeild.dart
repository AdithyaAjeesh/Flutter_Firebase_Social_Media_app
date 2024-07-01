import 'package:flutter/material.dart';

class AuthTextfeild extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final IconData icon;
  const AuthTextfeild({
    super.key,
    required this.controller,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 213, 156, 156),
        ),
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 213, 156, 156),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 213, 156, 156),
            ),
          ),
          hintText: text,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 213, 156, 156),
          ),
        ),
      ),
    );
  }
}
