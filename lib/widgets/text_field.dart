import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  const CustomTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: null,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      onChanged: (value) {
        
      },
    );
  }
}
