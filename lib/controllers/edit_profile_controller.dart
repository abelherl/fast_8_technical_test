import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:payuung/constants/constants.dart';
import 'package:payuung/controllers/profile_controller.dart';
import 'package:payuung/entities/profile/profile_entity.dart';
import 'package:payuung/failures/failure.dart';
import 'package:payuung/helpers/global_helper.dart';
import 'package:payuung/usecases/profile/get_profile_info_usecase.dart';
import 'package:payuung/usecases/profile/save_profile_info_usecase.dart';
import 'package:payuung/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

enum EditProfileStatus { initial, loading, loaded, saved, imageUploaded, error }

class EditProfileController extends GetxController {
  EditProfileController({required this.tabController});

  final Rx<TabController> tabController;
  final ktpFile = Rxn<File>();
  final profile = Rxn<ProfileEntity>();
  final message = ''.obs;
  final status = EditProfileStatus.initial.obs;
  final uploaded = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await _initData();
  }

  Future<void> _initData() async {
    status.value = EditProfileStatus.loading;

    final prefs = Get.find<SharedPreferences>();
    final path = prefs.getString(Constants.prefsKtpPath);

    if (path != null) ktpFile.value = File(path);

    final usecase = Get.find<GetProfileInfoUsecase>();

    final result = await usecase.call();

    result.fold(
      (l) => _onError(l),
      (r) {
        profile.value = r;
        status.value = EditProfileStatus.loaded;
      },
    );
  }

  void editProfile(ProfileEntity profile) => this.profile.value = profile;

  void previousTab() {
    final previousIndex = tabController.value.index - 1;
    if (previousIndex >= 0) {
      tabController.value.animateTo(previousIndex);
    }
  }

  void nextTab() {
    final nextIndex = tabController.value.index + 1;
    if (nextIndex < tabController.value.length) {
      tabController.value.animateTo(nextIndex);
    }
  }

  Future<void> clearKtp() async {
    ktpFile.value!.delete();
    ktpFile.value = null;
    ktpFile.refresh();
  }

  Future<void> uploadKtp(BuildContext context) async {
    final isCamera = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Upload Options', style: Constants.styleH2),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Camera',
                    onTap: () => Navigator.of(context).pop(true),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: CustomButton(
                    text: 'Gallery',
                    onTap: () => Navigator.of(context).pop(false),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final source = isCamera ? ImageSource.camera : ImageSource.gallery;
    final image = await ImagePicker().pickImage(source: source);

    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final file = File(path.join(directory.path, path.basename('temp-ktp')));
      await file.writeAsBytes(await image.readAsBytes());

      ktpFile.value = file;
      uploaded.value = true;
      ktpFile.refresh();
      status.value = EditProfileStatus.imageUploaded;
      GlobalHelper.successSnackbar('KTP successfully uploaded!');
    }
  }

  Future<void> saveProfile() async {
    status.value = EditProfileStatus.loading;

    final ktpFile = this.ktpFile.value;

    if (ktpFile != null && uploaded.value) {
      final prefs = await SharedPreferences.getInstance();
      final directory = await getApplicationDocumentsDirectory();
      final filePath = path.join(directory.path, path.basename('ktp'));
      await ktpFile.copy(filePath);

      prefs.setString(Constants.prefsKtpPath, filePath);

      // * Delete temp file
      ktpFile.delete();
    }

    final usecase = Get.find<SaveProfileInfoUsecase>();

    final result = await usecase.call(profile.value!);

    final controller = Get.find<ProfileController>();
    await controller.getProfile();

    result.fold(
      (l) => _onError(l),
      (r) {
        status.value = EditProfileStatus.saved;
        Get.back();
        GlobalHelper.successSnackbar('Profile saved successfully');
      },
    );
  }

  void _onError(Failure l) {
    message.value = l.message;
    status.value = EditProfileStatus.error;
    GlobalHelper.errorSnackbar(l.message);
  }
}
