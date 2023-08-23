import 'package:flutter/material.dart';

class ReminderInterface extends StatefulWidget {
  const ReminderInterface({super.key});

  @override
  State<ReminderInterface> createState() => _ReminderInterfaceState();
}

class _ReminderInterfaceState extends State<ReminderInterface> {
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
                child: const Text("reminder title"),
              ),
              SwitchListTile(
                title: const Text("Time"),
                value: true,
                onChanged: (bool value) {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
