import 'package:flutter/material.dart';

class FormCheckbox extends StatefulWidget {
  bool? checked = false;
  final Function SetBreakingChange;

  FormCheckbox(this.SetBreakingChange);

  @override
  State<FormCheckbox> createState() => _FormCheckboxState();
}

class _FormCheckboxState extends State<FormCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Colors.blueAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      value: widget.checked,
      onChanged: (bool? value) {
        setState(() {
          widget.checked = value;
          widget.SetBreakingChange(value);
        });
      },
    );
  }
}
