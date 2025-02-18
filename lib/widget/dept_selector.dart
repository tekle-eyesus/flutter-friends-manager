import 'package:flutter/material.dart';

class departmentBtn extends StatefulWidget {
  final void Function(String selectedCategory) onCategorySelect;
  const departmentBtn({super.key, required this.onCategorySelect});

  @override
  State<departmentBtn> createState() => _departmentBtnState();
}

class _departmentBtnState extends State<departmentBtn> {
  String selectedCategory = "software engineer";

  List<String> departmentList = [
    "software engineer",
    "IS",
    "CS",
    "IT",
    "Mechanical Engineer"
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: "department",
        labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
        fillColor: Color.fromARGB(255, 197, 237, 255),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      value: selectedCategory, // Initial value
      items: departmentList.map(
        (String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category),
          );
        },
      ).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedCategory = newValue!;
          widget.onCategorySelect(selectedCategory);
        });
      },
    );
  }
}
