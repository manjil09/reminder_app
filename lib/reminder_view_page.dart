import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/database/database.dart';
import 'package:reminder_app/main.dart';
import 'package:reminder_app/notification/notification_api.dart';
import 'package:reminder_app/widgets/plain_text_button.dart';

class ReminderInterface extends StatefulWidget {
  final MyDatabase database;
  final ReminderData reminderData;

  const ReminderInterface({
    super.key,
    required this.database,
    required this.reminderData,
  });

  @override
  State<ReminderInterface> createState() => _ReminderInterfaceState();
}

class _ReminderInterfaceState extends State<ReminderInterface> {
  var controller = TextEditingController();

  // Initialize with a default value
  bool isDateChanged = false;
  bool isTimeChanged = false;
  bool isTimeSelectionChanged = false;
  bool isTitleChanged = false;
  // bool isTitleChanged = false;
  late String newTitle;
  late DateTime newDate;
  late TimeOfDay newTime;

  late bool timeSelected;
  late bool isCompleted;
  late DateTime dateAndTime;
  late String title;
  late int id;
  late String selectedDate;
  late String selectedTime;
  late int count;

  @override
  void initState() {
    super.initState();
    timeSelected = widget.reminderData.timeSelected;
    title = widget.reminderData.title;
    id = widget.reminderData.id;
    isCompleted = widget.reminderData.isCompleted;
    dateAndTime = widget.reminderData.dateAndTime ?? DateTime.now();
    selectedDate = DateFormat('MMMMEEEEd').format(dateAndTime);
    selectedTime = DateFormat('jm').format(dateAndTime).toString();

    newTitle = title;
    newDate = dateAndTime;
    newTime = TimeOfDay.fromDateTime(dateAndTime);
    controller.text = title;
    getCount();
  }

  Future<void> getCount() async {
    count = await widget.database.countRows();
  }

  bool validTitle() {
    return true;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateAndTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    var pickedDate = DateFormat('MMMMEEEEd').format(picked!);
    if (pickedDate != selectedDate) {
      setState(() {
        newDate = picked;
        selectedDate = pickedDate;
        // widget.database.updateReminder(id, reminderData)
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
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 30),
                  onChanged: (value) {
                    isTitleChanged = true;
                    newTitle = controller.text;
                  },
                ),
                // CustomTextField(controller: controller,)
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
                            isTimeSelectionChanged = true;
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
                          onPressed: () {
                            saveButtonPressed();
                            setNotification();
                            Navigator.pop(context);
                          },
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

  void saveButtonPressed() {
    if (isTimeChanged ||
        isDateChanged ||
        isTimeSelectionChanged ||
        isTitleChanged) {
      dateAndTime = DateTime(
        newDate.year,
        newDate.month,
        newDate.day,
        newTime.hour,
        newTime.minute,
      );
      widget.database.updateReminder(
        id,
        ReminderData(
            id: id,
            title: newTitle,
            isCompleted: isCompleted,
            timeSelected: timeSelected,
            dateAndTime: dateAndTime),
      );
    }
  }

  void setNotification() async {
    if (timeSelected) {
      if (dateAndTime.isAfter(DateTime.now())) {
        Noti().scheduleNotification(
            id: count + 1,
            title: newTitle,
            body: "$selectedDate  $selectedTime",
            scheduledDateTime: dateAndTime);
      } else {
        var scaffold = ScaffoldMessenger.of(context);
        scaffold.showSnackBar(const SnackBar(
          content: Center(
              child: Text(
            'The set Date and Time has already past',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )),
          backgroundColor: Colors.grey,
        ));
      }
    } else {
      await flutterLocalNotificationsPlugin.cancel(count + 1);
    }
  }
}
