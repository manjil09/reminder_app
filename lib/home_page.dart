import 'package:flutter/material.dart';
import 'package:reminder_app/add_reminder.dart';
import 'package:reminder_app/database/database.dart';
import 'package:reminder_app/main.dart';
import 'package:reminder_app/notification/notification_api.dart';
import 'package:reminder_app/widgets/reminder_item.dart';

class HomePage extends StatefulWidget {
  final MyDatabase database;
  const HomePage({super.key, required this.database});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int remainingReminder = 0;
  @override
  void initState() {
    super.initState();
    updateRemainingReminderCount();
  }

  Future<void> updateRemainingReminderCount() async {
    int count = await widget.database.countRemaining();
    setState(() {
      remainingReminder = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    final database = widget.database;

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.grey.shade100,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: Column(
                  children: [
                    const Text("Reminders",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w500)),
                    Text("$remainingReminder reminder/s remaining",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AddReminderInterface(
                            database: database,
                            updateRemainingReminderCount:
                                updateRemainingReminderCount,
                          ),
                        ),
                      ),
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
              StreamBuilder(
                stream: database.watchAllReminder(),
                builder: (context, AsyncSnapshot<List<ReminderData>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while waiting for data.
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Handle errors, e.g., show an error message.
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    // Handle the case where there is no data or it's empty.
                    return const Center(child: Text('No reminders available.'));
                  } else {
                    // Render the list of reminders when data is available.
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return ReminderItem(
                            callback: updateRemainingReminderCount,
                            database: database,
                            reminderData: snapshot.data![index],
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade400,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () => Noti.showBigTextNotification(
                    title: "New message title",
                    body: "Your long body",
                    fln: flutterLocalNotificationsPlugin,
                  ),
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
