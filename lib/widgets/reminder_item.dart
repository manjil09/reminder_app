import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/database/database.dart';
import 'package:reminder_app/main.dart';
import 'package:reminder_app/notification/notification_api.dart';
import 'package:reminder_app/reminder_view_page.dart';

class ReminderItem extends StatefulWidget {
  final MyDatabase database;
  final ReminderData reminderData;
  const ReminderItem(
      {super.key, required this.database, required this.reminderData});

  @override
  State<ReminderItem> createState() => _ReminderItemState();
}

class _ReminderItemState extends State<ReminderItem> {
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ReminderInterface(
                  database: widget.database,
                  reminderData: widget.reminderData,
                )));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Checkbox(
              value: widget.reminderData.isCompleted,
              onChanged: (bool? value) async {
                int id = widget.reminderData.id;
                String title = widget.reminderData.title;
                bool timeSelected = widget.reminderData.timeSelected;

                setState(() {
                  widget.database.updateReminder(
                    widget.reminderData.id,
                    ReminderData(
                        id: id,
                        title: title,
                        isCompleted: value!,
                        timeSelected: timeSelected),
                  );

                  isCompleted = value;
                  // Provider.of<MyDatabase>(context);
                });

                if (timeSelected) {
                  if (timeSelected) {
                    DateTime dateAndTime = widget.reminderData.dateAndTime!;
                    var selectedDate =
                        DateFormat('MMMMEEEEd').format(dateAndTime);
                    var selectedTime =
                        DateFormat('jm').format(dateAndTime).toString();
                    if (isCompleted) {
                      await flutterLocalNotificationsPlugin.cancel(id);
                    } else {
                      if (dateAndTime.isAfter(DateTime.now())) {
                        Noti().scheduleNotification(
                            id: id,
                            title: title,
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
                    }
                  }
                }
              },
            ),
            Text(
              widget.reminderData.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
