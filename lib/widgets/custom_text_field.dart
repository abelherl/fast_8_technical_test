import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payuung/constants/constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.title,
    required this.initialValue,
    this.required = false,
    this.disabled = false,
    this.numeric = false,
    this.noBottomPadding = false,
    required this.onChanged,
  });

  final String title;
  final String initialValue;
  final bool required;
  final bool disabled;
  final bool numeric;
  final bool noBottomPadding;
  final Function(String) onChanged;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    final fillColor =
        widget.disabled ? Colors.black.withOpacity(0.08) : Colors.white;
    final keyboardType = widget.numeric ? TextInputType.number : null;
    final formatter =
        widget.numeric ? [FilteringTextInputFormatter.digitsOnly] : null;

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
          keyboardType: keyboardType,
          inputFormatters: formatter,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            filled: true,
            fillColor: fillColor,
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
            enabled: !widget.disabled,
          ),
          validator: _validator,
          onChanged: widget.onChanged,
        ),
        if (!widget.noBottomPadding) const SizedBox(height: 18),
      ],
    );
  }

  String? _validator(String? value) {
    if (value == '' && widget.required) {
      return 'This field is required';
    }
    return null;
  }
}
