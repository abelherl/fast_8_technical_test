import 'package:flutter/material.dart';

abstract class CustomTab extends StatefulWidget {
  const CustomTab({super.key, required this.formKey});

  final GlobalKey<FormState> formKey;

  int getTabIndex();
  String getTabName();
}