import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GlobalHelper {
  const GlobalHelper._();

  static final priceFormatter = NumberFormat("#,##0", "en_US");

  static String formatToRupiah(num price) {
    final formattedPrice = priceFormatter.format(price);
    return 'Rp $formattedPrice';
  }

  static String formatToDiscount(num percentage) {
    final regex = RegExp(r'([.]*0)(?!.*\d)');
    final formatted = percentage.toString().replaceAll(regex, '');
    return '$formatted% OFF';
  }

  static void successSnackbar(String msg) {
    Get.snackbar(
      'Success!',
      msg,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(8),
    );
  }

  static void errorSnackbar(String msg) {
    Get.snackbar(
      'Error!',
      msg,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(8),
    );
  }

  static String formatDate(DateTime dateTime) {
    final formatter = DateFormat('dd MMMM yyyy');
    return formatter.format(dateTime);
  }
}