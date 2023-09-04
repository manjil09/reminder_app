import 'package:flutter/material.dart';
import 'package:reminder_app/database/database.dart';
import 'package:reminder_app/reminder_view_page.dart';

class ReminderItem extends StatefulWidget {
  
  final MyDatabase database;
  final ReminderData reminderData;
  const ReminderItem(
      {super.key,
      required this.database,
      required this.reminderData});

  @override
  State<ReminderItem> createState() => _ReminderItemState();
}

class _ReminderItemState extends State<ReminderItem> {
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ReminderInterface(database: widget.database,reminderData: widget.reminderData,)));
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
              onChanged: (bool? value) {
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
              },
            ),
            Text(widget.reminderData.title)
          ],
        ),
      ),
    );
  }
}
