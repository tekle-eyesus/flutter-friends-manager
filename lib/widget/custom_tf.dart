import 'package:flutter/material.dart';

// Reusable Custom TextField
class CustomTextField extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String errorText;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.icon,
    this.isPassword = false,
    this.errorText = "",
    required this.controller,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool? isVisible;
  //hide password toggle
  void togglePassword() {
    setState(() {
      isVisible = !isVisible!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword && isVisible!,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          errorText: widget.errorText == "" ? null : widget.errorText,
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.8),
            fontWeight: FontWeight.bold,
          ),
          suffixIcon: (widget.isPassword)
              ? IconButton(
                  onPressed: togglePassword,
                  icon: isVisible!
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off))
              : null,
          prefixIcon: Icon(
            widget.icon,
            color: const Color.fromARGB(221, 54, 23, 5),
          ),
          filled: true,
          fillColor: Colors.grey.shade300,
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
