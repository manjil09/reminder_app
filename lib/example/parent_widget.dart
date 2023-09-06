import 'package:flutter/material.dart';
import 'package:reminder_app/example/child_widget.dart';

class ParentWidget extends StatefulWidget {
  const ParentWidget({super.key});

  @override
  State<ParentWidget> createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  String hobby = "playing";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Somebody is $hobby"),
          ChildWidget(hobby: hobby),
        ],
      ),
    );
  }
}
