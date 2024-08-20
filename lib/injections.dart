import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:payuung/controllers/profile_controller.dart';
import 'package:payuung/controllers/promo_controller.dart';
import 'package:payuung/datasources/profile_datasource.dart';
import 'package:payuung/datasources/promo_datasource.dart';
import 'package:payuung/entities/promo/promo_entity.dart';
import 'package:payuung/repositories/profile_repository.dart';
import 'package:payuung/repositories/promo_repository.dart';
import 'package:payuung/usecases/profile/get_profile_info_usecase.dart';
import 'package:payuung/usecases/profile/save_profile_info_usecase.dart';
import 'package:payuung/usecases/promo/get_all_promo_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInjections extends Bindings {
  @override
  Future<void> dependencies() async {
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
}