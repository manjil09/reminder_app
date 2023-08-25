import 'package:flutter/material.dart';
import 'package:reminder_app/reminder_view_page.dart';

class ReminderItem extends StatefulWidget {
  const ReminderItem({super.key});

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
              value: isCompleted,
              onChanged: (bool? value) {
                setState(() {
                  isCompleted = value ?? false;
                });
              },
            ),
            const Text("Item 1")
          ],
        ),
      ),
    );
  }
}
