import 'package:flutter/material.dart';

class ChildWidget extends StatefulWidget {
  final String hobby;
  const ChildWidget({super.key, required this.hobby});
  
  @override
  State<ChildWidget> createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget> {
  TextEditingController controller = TextEditingController();
  late String newHobby;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onEditingComplete: (){
        newHobby = controller.text; 
      },
    );
  }
}