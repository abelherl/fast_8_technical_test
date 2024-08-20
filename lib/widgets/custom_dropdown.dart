import 'package:flutter/material.dart';
import 'package:payuung/constants/constants.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.title,
    required this.items,
    required this.value,
    this.required = false,
    required this.onChanged,
  });

  final String title;
  final List<String> items;
  final String value;
  final bool required;
  final Function(String? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (required)
              const Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(width: 4),
            Text(
              title.toUpperCase(),
              style: Constants.styleH3,
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: DropdownButtonFormField<String>(
            items: items
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            value: value,
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            decoration: const InputDecoration(border: InputBorder.none),
            onChanged: onChanged,
            validator: _validator,
          ),
        ),
        const SizedBox(height: 18),
      ],
    );
  }

  String? _validator(String? value) {
    if ((value == '' || value == null) && required) {
      return 'This field is required';
    }
    return null;
  }
}
