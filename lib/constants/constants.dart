import 'package:flutter/material.dart';

class Constants {
  const Constants._();

  // * Prefs
  static const prefsProfile = 'profile';
  static const prefsKtpPath = 'ktp_path';

  // * Colors
  static const primaryColor = Color(0xFFF6C029);
  static const primaryColorLight = Color(0xFFFFEBBD);

  // * Icons
  static const iconPath = 'assets/icons';
  static const iconAll = '$iconPath/all.svg';
  static const iconBike = '$iconPath/bike.svg';
  static const iconCar = '$iconPath/car.svg';
  static const iconChat = '$iconPath/chat.svg';
  static const iconFinance = '$iconPath/finance.svg';
  static const iconGroup = '$iconPath/group.svg';
  static const iconHealth = '$iconPath/health.svg';
  static const iconHome = '$iconPath/home.svg';
  static const iconMedic = '$iconPath/medic.svg';
  static const iconMerchandise = '$iconPath/merchandise.svg';
  static const iconOfficer = '$iconPath/officer.svg';
  static const iconPlan = '$iconPath/plan.svg';
  static const iconSelfDevelopment = '$iconPath/self-development.svg';

  // * Typography
  static const styleH2 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );
  static const styleH3 = TextStyle(fontSize: 11);
  static const styleBody2 = TextStyle(fontSize: 12);
}