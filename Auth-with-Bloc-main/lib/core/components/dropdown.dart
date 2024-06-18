
import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final List<Map<String, dynamic>> options;
  final String selectedValue;
  final ValueChanged<String?> onChanged;

  DropdownWidget({required this.options, required this.selectedValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select an option:"),
        DropdownButton<String>(
          value: selectedValue.isNotEmpty ? selectedValue : null,
          onChanged: (String? value) {
            onChanged(value ?? ""); // Set an empty string if null
          },
        items: options.map((Map<String, dynamic> option) {
        return DropdownMenuItem<String>(
        value: option["value"],
        child: Text(option["name"]),
        );
        }).toList(),
        ),
      ],
    );
  }
}

