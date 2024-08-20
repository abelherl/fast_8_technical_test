import 'package:flutter/material.dart';
import 'package:payuung/constants/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.isOutline = false,
    required this.onTap,
  });

  final String text;
  final bool isOutline;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(6);

    if (isOutline) {
      return Material(
        color: Colors.white,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              border: Border.all(color: Constants.primaryColor),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Constants.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
    
    return Material(
      color: Constants.primaryColor,
      borderRadius: borderRadius,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: borderRadius,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
