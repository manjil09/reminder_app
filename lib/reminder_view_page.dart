import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/database/database.dart';
import 'package:reminder_app/widgets/plain_text_button.dart';

class ReminderInterface extends StatefulWidget {
  final MyDatabase database;
  final ReminderData reminderData;
  const ReminderInterface({super.key, required this.database, required this.reminderData});

  @override
  State<ReminderInterface> createState() => _ReminderInterfaceState();
}

class _ReminderInterfaceState extends State<ReminderInterface> {
  bool timeSelected = false;
  var selectedDate = DateFormat('MMMMEEEEd').format(DateTime.now());
  var selectedTime = DateFormat('jm').format(DateTime.now()).toString();

  bool validTitle() {
    return true;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    var pickedDate = DateFormat('MMMMEEEEd').format(picked!);
    if (pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    DateTime dateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      picked!.hour,
      picked.minute,
    );
    var pickedTime = DateFormat('jm').format(dateTime).toString();
    if (pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.grey.shade100,
          child: Column(
            children: [
              Container(
                width: width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 12),
                  child: Text(
                    "reminder title",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SwitchListTile(
                        title: const Text("Time"),
                        value: timeSelected,
                        onChanged: (bool value) {
                          setState(() {
                            timeSelected = value;
                          });
                        },
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
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 0, 0, 0),
                                        child: PlainTextButton(
                                          text: selectedDate,
                                          onPressed: () => _selectDate(context),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 0, 0, 0),
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
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                      TextButton(
                          onPressed: !validTitle() ? null : () {},
                          child: const Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
