import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/widgets/plain_text_button.dart';

class CustomDateTimeSelector extends StatefulWidget {
  final DateTime dateAndTime;
  const CustomDateTimeSelector({super.key, required this.dateAndTime});

  @override
  State<CustomDateTimeSelector> createState() => _CustomDateTimeSelectorState();
}

class _CustomDateTimeSelectorState extends State<CustomDateTimeSelector> {
  bool isDateChanged = false;
  bool isTimeChanged = false;
  bool isTimeSelectionChanged = false;

  late DateTime newDate;
  late TimeOfDay newTime;

  late bool timeSelected;
  late DateTime dateAndTime;
  late String selectedDate;
  late String selectedTime;

  @override
  void initState() {
    super.initState();

    dateAndTime = widget.dateAndTime;
    selectedDate = DateFormat('MMMMEEEEd').format(dateAndTime);
    selectedTime = DateFormat('jm').format(dateAndTime).toString();

    newDate = dateAndTime;
    newTime = TimeOfDay.fromDateTime(dateAndTime);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateAndTime,
      firstDate: DateTime(2023),
      lastDate: DateTime(2101),
    );
    var pickedDate = DateFormat('MMMMEEEEd').format(picked!);
    if (pickedDate != selectedDate) {
      setState(() {
        newDate = picked;
        selectedDate = pickedDate;
      });
    }
    isDateChanged = true;
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(dateAndTime));
    DateTime dateTime = DateTime(
      dateAndTime.year,
      dateAndTime.month,
      dateAndTime.day,
      picked!.hour,
      picked.minute,
    );
    var pickedTime = DateFormat('jm').format(dateTime).toString();
    if (pickedTime != selectedTime) {
      setState(() {
        newTime = picked;
        selectedTime = pickedTime;
      });
    }
    isTimeChanged = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: const Text("Time"),
          value: timeSelected,
          onChanged: (bool value) => setState(() {
            timeSelected = value;
            isTimeSelectionChanged = true;
          }),
        ),
        Visibility(
          visible: timeSelected,
          maintainSize: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.notifications),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: PlainTextButton(
                            text: selectedDate,
                            onPressed: () => _selectDate(context),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                          child: PlainTextButton(
                            text: selectedTime,
                            onPressed: () => _selectTime(context),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.loop),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Text("Don't repeat"),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.volume_up),
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Text("Medium"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
