import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payuung/entities/promo/promo_entity.dart';
import 'package:payuung/failures/failure.dart';
import 'package:payuung/helpers/global_helper.dart';
import 'package:payuung/usecases/promo/get_all_promo_usecase.dart';

enum PromoStatus { initial, loading, loaded, error }

class PromoController extends GetxController {
  final promos = <PromoEntity>[].obs;
  final selectedPromo = Rxn<PromoEntity>();
  final message = ''.obs;
  final status = PromoStatus.initial.obs;

  @override
  void onInit() async {
    super.onInit();
    await getAllPromo();
  }

  Future<void> getAllPromo() async {
    status.value = PromoStatus.loading;

    final usecase = Get.find<GetAllPromoUsecase>();

    final result = await usecase.call();

    result.fold(
      (l) => _onError(l),
      (r) {
        promos.value = r;
        status.value = PromoStatus.loaded;
      },
    );
  }

  void selectPromo(PromoEntity promo) {
    selectedPromo.value = promo;
  }

  void backToPromoList() {
    selectedPromo.value = null;
    Get.back();
  }

  void _onError(Failure l) {
    message.value = l.message;
    status.value = PromoStatus.error;
    GlobalHelper.errorSnackbar(l.message);
  }
}
