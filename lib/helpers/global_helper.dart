import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:payuung/controllers/profile_controller.dart';
import 'package:payuung/controllers/promo_controller.dart';
import 'package:payuung/datasources/profile_datasource.dart';
import 'package:payuung/datasources/promo_datasource.dart';
import 'package:payuung/repositories/profile_repository.dart';
import 'package:payuung/repositories/promo_repository.dart';
import 'package:payuung/usecases/profile/get_profile_info_usecase.dart';
import 'package:payuung/usecases/profile/save_profile_info_usecase.dart';
import 'package:payuung/usecases/promo/get_all_promo_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:payuung/entities/promo/promo_entity.dart';

class GlobalHelper {
  const GlobalHelper._();

  static final priceFormatter = NumberFormat("#,##0", "en_US");

  static Future<void> init() async {
    await _initHive();
    await _initSharedPreferences();
    await _initDatasources();
    await _initRepositories();
    await _initUsecases();
    await _initControllers();
  }

  static Future<void> _initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(PromoEntityAdapter());

    final box = await Hive.openBox<PromoEntity>('promo');
    Get.put<Box<PromoEntity>>(box);
  }

  static Future<void> _initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(prefs);
  }

  static Future<void> _initDatasources() async {
    // * Profile
    final prefs = Get.find<SharedPreferences>();
    Get.put<ProfileDatasource>(ProfileDatasourceImpl(prefs));

    // * Promo
    final box = Get.find<Box<PromoEntity>>();
    Get.put<PromoDatasource>(PromoDatasourceImpl(box));
  }

  static Future<void> _initRepositories() async {
    // * Profile
    final profileDatasource = Get.find<ProfileDatasource>();
    Get.put<ProfileRepository>(ProfileRepositoryImpl(profileDatasource));

    // * Promo
    final promoDatasource = Get.find<PromoDatasource>();
    Get.put<PromoRepository>(PromoRepositoryImpl(promoDatasource));
  }

  static Future<void> _initUsecases() async {
    // * Profile
    final profileRepository = Get.find<ProfileRepository>();
    Get.put<GetProfileInfoUsecase>(GetProfileInfoUsecase(profileRepository));
    Get.put<SaveProfileInfoUsecase>(SaveProfileInfoUsecase(profileRepository));

    // * Promo
    final promoRepository = Get.find<PromoRepository>();
    Get.put<GetAllPromoUsecase>(GetAllPromoUsecase(promoRepository));
  }

  static Future<void> _initControllers() async {
    Get.put<PromoController>(PromoController());
    Get.put<ProfileController>(ProfileController());
  }

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