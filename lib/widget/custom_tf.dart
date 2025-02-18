import 'package:flutter/material.dart';

// Reusable Custom TextField
class CustomTextField extends StatefulWidget {
  final String labelText;
  final IconData icon;

  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.icon,
    required this.controller,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(
            widget.icon,
            color: const Color.fromARGB(221, 54, 23, 5),
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 197, 237, 255),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}
