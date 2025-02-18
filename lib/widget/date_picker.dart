import 'package:class_1/helper/helper_fun.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final void Function(DateTime date) onDateSelected;
  const DatePicker({super.key, required this.onDateSelected});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 197, 237, 255),
      ),
      child: ListTile(
        leading: Image.asset(
          "assets/icons/birthday.png",
          width: 30,
          height: 30,
        ),
        title: Text(
          formatBirthday(selectedDate.toString()),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        trailing: IconButton(
          onPressed: () async {
            final DateTime? dateTime = await showDatePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(3000),
                initialDate: selectedDate);
            if (dateTime != null) {
              setState(
                () {
                  selectedDate = dateTime;
                  widget.onDateSelected(selectedDate);
                },
              );
            }
          },
          icon: const Icon(
            Icons.calendar_month_rounded,
            size: 30,
          ),
        ),
      ),
    );
  }
}
