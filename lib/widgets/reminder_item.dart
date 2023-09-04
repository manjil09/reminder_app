import 'package:flutter/material.dart';
import 'package:reminder_app/reminder_view_page.dart';

class ReminderItem extends StatefulWidget {
  final bool isCompleted;
  final String title;
  const ReminderItem({super.key, required this.isCompleted, required this.title});

  @override
  State<ReminderItem> createState() => _ReminderItemState();
}

class _ReminderItemState extends State<ReminderItem> {
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ReminderInterface()));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Checkbox(
              value: widget.isCompleted,
              onChanged: (bool? value) {
                setState(() {
                  
                  isCompleted = value ?? false;
                  // Provider.of<MyDatabase>(context);
                });
              },
            ),
            Text(widget.title)
          ],
        ),
      ),
    );
  }
}
