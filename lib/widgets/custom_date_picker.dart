import 'package:flutter/material.dart';
import 'package:payuung/constants/constants.dart';
import 'package:payuung/helpers/global_helper.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.title,
    required this.initialValue,
    this.required = false,
    required this.onChanged,
  });

  final String title;
  final DateTime initialValue;
  final bool required;
  final Function(DateTime) onChanged;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: GlobalHelper.formatDate(widget.initialValue),
    );
    _controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (widget.required)
              const Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(width: 4),
            Text(
              widget.title.toUpperCase(),
              style: Constants.styleH3,
            ),
          ],
        ),
        const SizedBox(height: 6),
        TextFormField(
          autovalidateMode: AutovalidateMode.always,
          controller: _controller,
          onTap: _onTap,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.black12),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.black38),
            ),
          ),
          readOnly: true,
          validator: _validator,
        ),
        const SizedBox(height: 18),
      ],
    );
  }

  Future<void> _onTap() async {
    final result = await showDatePicker(
      context: context,
      initialDate: widget.initialValue,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );

    if (result != null) {
      widget.onChanged(result);
      _controller.text = GlobalHelper.formatDate(result);
    }
  }

  String? _validator(String? value) {
    if (value == '' && widget.required) {
      return 'This field is required';
    }
    return null;
  }
}
