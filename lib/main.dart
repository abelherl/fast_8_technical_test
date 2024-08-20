import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:payuung/constants/constants.dart';
import 'package:payuung/helpers/global_helper.dart';
import 'package:payuung/screens/home/home_screen.dart';

void main() async {
  await GlobalHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Payuung Dupe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Constants.primaryColor),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
