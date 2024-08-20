import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payuung/constants/constants.dart';
import 'package:payuung/controllers/edit_profile_controller.dart';
import 'package:payuung/entities/profile/address/address_entity.dart';
import 'package:payuung/screens/edit_profile/edit_profile_base.dart';
import 'package:payuung/widgets/custom_button.dart';
import 'package:payuung/widgets/custom_dropdown.dart';
import 'package:payuung/widgets/custom_tab.dart';
import 'package:payuung/widgets/custom_text_field.dart';

class AddressTab extends CustomTab {
  const AddressTab({super.key, required super.formKey});

  @override
  int getTabIndex() => 1;

  @override
  String getTabName() => 'Address';

  @override
  State<StatefulWidget> createState() => _AddressTabState();
}

class _AddressTabState extends State<AddressTab> {
  var _isSameCurrentData = false;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<EditProfileController>();
    return Obx(() {
      final profile = c.profile.value;
      final address = profile?.address;

      _setCurrentAddressData(c);

      if (address == null) {
        return const Center(child: Text('Profile not found'));
      }

      return EditProfileTabBase(
        formKey: widget.formKey,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(2, 2),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                const _KtpPictureSection(),
                const SizedBox(height: 18),
                CustomTextField(
                  title: 'NIK',
                  initialValue: '${address.nik}',
                  required: true,
                  noBottomPadding: true,
                  numeric: true,
                  onChanged: (value) {
                    address.nik = int.parse(value);
                    _editProfile(c, address);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          CustomTextField(
            title: 'Address On ID',
            initialValue: address.address,
            required: true,
            onChanged: (value) {
              address.address = value;
              _editProfile(c, address);
            },
          ),
          CustomDropdown(
            title: 'Province',
            items: const ['East Java', 'Test', 'Other Test'],
            value: address.province,
            required: true,
            onChanged: (value) {
              address.province = value!;
              _editProfile(c, address);
            },
          ),
          CustomDropdown(
            title: 'City',
            items: const ['Malang', 'Test', 'Other Test'],
            value: address.city,
            required: true,
            onChanged: (value) {
              address.city = value!;
              _editProfile(c, address);
            },
          ),
          CustomDropdown(
            title: 'Subdistrict',
            items: const ['Dau', 'Test', 'Other Test'],
            value: address.subdistrict,
            required: true,
            onChanged: (value) {
              address.subdistrict = value!;
              _editProfile(c, address);
            },
          ),
          CustomDropdown(
            title: 'Ward',
            items: const ['Landungsari', 'Test', 'Other Test'],
            value: address.ward,
            required: true,
            onChanged: (value) {
              address.ward = value!;
              _editProfile(c, address);
            },
          ),
          CustomTextField(
            title: 'Postal Code',
            initialValue: '${address.postalCode}',
            required: true,
            numeric: true,
            noBottomPadding: true,
            onChanged: (value) {
              address.postalCode = int.parse(value);
              _editProfile(c, address);
            },
          ),
          const SizedBox(height: 12),
          Transform.translate(
            offset: const Offset(-12, 0),
            child: Row(
              children: [
                Checkbox(
                  value: _isSameCurrentData,
                  fillColor:
                      const MaterialStatePropertyAll(Constants.primaryColor),
                  onChanged: (value) =>
                      setState(() => _isSameCurrentData = value!),
                ),
                const Expanded(
                  child: Text(
                    'Current address is the same with\nthe address on ID.',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (!_isSameCurrentData) const _CurrentDataForm(),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Back',
                  isOutline: true,
                  onTap: _onBack,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButton(
                  text: 'Next',
                  onTap: _onNext,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  void _setCurrentAddressData(EditProfileController controller) {
    if (_isSameCurrentData) {
      final profile = controller.profile.value!;

      final originalAddress = profile.address;
      final updatedAddress = AddressEntity(
        nik: originalAddress.nik,
        address: originalAddress.address,
        province: originalAddress.province,
        city: originalAddress.city,
        subdistrict: originalAddress.subdistrict,
        ward: originalAddress.ward,
        postalCode: originalAddress.postalCode,
        currentAddress: originalAddress.address,
        currentProvince: originalAddress.province,
        currentCity: originalAddress.city,
        currentSubdistrict: originalAddress.subdistrict,
        currentWard: originalAddress.ward,
        currentPostalCode: originalAddress.postalCode,
      );

      profile.address = updatedAddress;

      controller.editProfile(profile);
    }
  }

  void _editProfile(EditProfileController controller, AddressEntity address) {
    final profile = controller.profile.value!;
    profile.address = address;
    controller.editProfile(profile);
  }

  void _onBack() {
    final c = Get.find<EditProfileController>();
    c.previousTab();
  }

  void _onNext() {
    if (!(widget.formKey.currentState?.validate() ?? false)) return;

    final c = Get.find<EditProfileController>();
    c.nextTab();
  }
}

class _KtpPictureSection extends StatelessWidget {
  const _KtpPictureSection();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<EditProfileController>();
    return Obx(() {
      final ktpFile = c.ktpFile.value;

      if (ktpFile != null) {
        try {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
              aspectRatio: 1.7,
              child: Stack(
                children: [
                  Image.memory(
                    ktpFile.readAsBytesSync(),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 36,
                      height: 36,
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Constants.primaryColorLight,
                      ),
                      child: GestureDetector(
                        onTap: () => c.uploadKtp(context),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.upload_file_outlined,
                              color: Constants.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } catch (_) {
          return _UploadSection(c);
        }
      }

      return _UploadSection(c);
    });
  }
}

class _UploadSection extends StatelessWidget {
  const _UploadSection(this.controller);

  final EditProfileController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => controller.uploadKtp(context),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Constants.primaryColorLight,
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.upload_file_outlined,
                  color: Constants.primaryColor,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text('Upload KTP'),
          ),
        ],
      ),
    );
  }
}

class _CurrentDataForm extends StatelessWidget {
  const _CurrentDataForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<EditProfileController>();
    final profile = c.profile.value;
    final address = profile?.address;

    if (address == null) {
      return const Center(child: Text('Profile not found'));
    }
    return Column(
      children: [
        CustomTextField(
          title: 'Current Address',
          initialValue: address.currentAddress,
          required: true,
          onChanged: (value) {
            address.currentAddress = value;
            _editProfile(c, address);
          },
        ),
        CustomDropdown(
          title: 'Current Province',
          items: const ['East Java', 'Test', 'Other Test'],
          value: address.currentProvince,
          required: true,
          onChanged: (value) {
            address.currentProvince = value!;
            _editProfile(c, address);
          },
        ),
        CustomDropdown(
          title: 'Current City',
          items: const ['Malang', 'Test', 'Other Test'],
          value: address.currentCity,
          required: true,
          onChanged: (value) {
            address.currentCity = value!;
            _editProfile(c, address);
          },
        ),
        CustomDropdown(
          title: 'Current Subdistrict',
          items: const ['Dau', 'Test', 'Other Test'],
          value: address.currentSubdistrict,
          required: true,
          onChanged: (value) {
            address.currentSubdistrict = value!;
            _editProfile(c, address);
          },
        ),
        CustomDropdown(
          title: 'Current Ward',
          items: const ['Landungsari', 'Test', 'Other Test'],
          value: address.currentWard,
          required: true,
          onChanged: (value) {
            address.currentWard = value!;
            _editProfile(c, address);
          },
        ),
        CustomTextField(
          title: 'Current Postal Code',
          initialValue: '${address.currentPostalCode}',
          required: true,
          numeric: true,
          onChanged: (value) {
            address.currentPostalCode = int.parse(value);
            _editProfile(c, address);
          },
        ),
      ],
    );
  }

  void _editProfile(EditProfileController controller, AddressEntity address) {
    final profile = controller.profile.value!;
    profile.address = address;
    controller.editProfile(profile);
  }
}
