import 'package:flutter/material.dart';
import 'package:reminder_app/widgets/reminder_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.grey.shade100,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Column(
                  children: [
                    Text("Reminders",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w500)),
                    Text("1 reminder/s remaining",
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ),
              const ReminderItem(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade400,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("Write a reminder"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
