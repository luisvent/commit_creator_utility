import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormTextField extends StatefulWidget {
  final String placeholder;
  final double height;
  final int maxLines;
  final TextEditingController? controller;
  final Function onChangeCallback;
  final List<TextInputFormatter>? inputFormatters;

  const FormTextField({required this.placeholder, this.controller, this.height = 30, this.maxLines = 1, required this.onChangeCallback, this.inputFormatters});

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextField(
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        onChanged: (value) => {widget.onChangeCallback()},
        maxLines: widget.maxLines,
        cursorHeight: 12,
        style: const TextStyle(
          fontSize: 12,
        ),
        decoration: InputDecoration(
          hintText: widget.placeholder,
          fillColor: const Color.fromARGB(50, 0, 0, 0),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(8),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.white54,
            ),
          ),
        ),
      ),
    );
  }
}
