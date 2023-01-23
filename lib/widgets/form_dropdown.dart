import 'package:flutter/material.dart';

import '../models/key_value.dart';

class FormDropdown extends StatefulWidget {
  final List<KeyValue> types;
  late String? dropdownValue;
  final Function SetTypeValue;

  FormDropdown(this.types, this.SetTypeValue) {
    dropdownValue = null;
  }

  @override
  State<FormDropdown> createState() => _FormDropdownState();
}

class _FormDropdownState extends State<FormDropdown> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        height: 30,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Color.fromARGB(50, 0, 0, 0),
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            padding: const EdgeInsets.all(0),
            alignedDropdown: true,
            child: DropdownButton<String>(
                itemHeight: 48,
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                isDense: false,
                value: widget.dropdownValue,
                icon: const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.expand_more),
                ),
                iconSize: 16,
                elevation: 16,
                style: const TextStyle(color: Colors.white, fontSize: 12),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    widget.SetTypeValue(value);
                    widget.dropdownValue = value!;
                  });
                },
                items: widget.types.map<DropdownMenuItem<String>>((KeyValue option) {
                  return DropdownMenuItem<String>(
                    value: option.key,
                    child: Text(option.value),
                  );
                }).toList()),
          ),
        ),
      ),
    );
  }
}
