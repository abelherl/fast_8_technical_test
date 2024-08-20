import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payuung/entities/profile/profile_entity.dart';
import 'package:payuung/failures/failure.dart';
import 'package:payuung/helpers/global_helper.dart';
import 'package:payuung/usecases/profile/get_profile_info_usecase.dart';
import 'package:payuung/usecases/profile/save_profile_info_usecase.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileController extends GetxController {
  final profile = Rxn<ProfileEntity>();
  final message = ''.obs;
  final status = ProfileStatus.initial.obs;

  @override
  void onInit() async {
    super.onInit();
    await _initDummyProfile();
  }

  Future<void> getProfile() async {
    status.value = ProfileStatus.loading;

    final usecase = Get.find<GetProfileInfoUsecase>();

    final result = await usecase.call();

    result.fold(
          (l) => _onError(l),
          (r) {
        profile.value = r;
        status.value = ProfileStatus.loaded;
      },
    );
  }

  Future<void> _initDummyProfile() async {
    status.value = ProfileStatus.loading;

    final profile = ProfileEntity.dummy();

    final usecase = Get.find<SaveProfileInfoUsecase>();

    final result = await usecase.call(profile);

    result.fold(
          (l) => _onError(l),
          (r) {
        this.profile.value = r;
        status.value = ProfileStatus.loaded;
      },
    );
  }

  void _onError(Failure l) {
    message.value = l.message;
    status.value = ProfileStatus.error;
    GlobalHelper.errorSnackbar(l.message);
  }
}
