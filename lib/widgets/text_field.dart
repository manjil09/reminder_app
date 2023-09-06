import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final Function textChanged;
  const CustomTextField(
      {super.key, required this.textChanged, required this.title});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: widget.title.isEmpty,
      keyboardType: TextInputType.multiline,
      minLines: 1,
      maxLines: null,
      decoration: const InputDecoration(border: InputBorder.none),
      style: const TextStyle(fontSize: 30),
      onChanged: (value) => widget.textChanged(value),
    );
  }
}
