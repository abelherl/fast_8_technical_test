import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payuung/controllers/edit_profile_controller.dart';
import 'package:payuung/entities/profile/biodata/biodata_entity.dart';
import 'package:payuung/screens/edit_profile/edit_profile_base.dart';
import 'package:payuung/widgets/custom_button.dart';
import 'package:payuung/widgets/custom_date_picker.dart';
import 'package:payuung/widgets/custom_dropdown.dart';
import 'package:payuung/widgets/custom_tab.dart';
import 'package:payuung/widgets/custom_text_field.dart';

class BiodataTab extends CustomTab {
  const BiodataTab({super.key, required super.formKey});

  @override
  int getTabIndex() => 0;

  @override
  String getTabName() => 'Biodata';

  @override
  State<StatefulWidget> createState() => _BiodataTabState();
}

class _BiodataTabState extends State<BiodataTab> {
  @override
  Widget build(BuildContext context) {
    final c = Get.find<EditProfileController>();
    return Obx(() {
      final profile = c.profile.value;
      final biodata = profile?.biodata;

      if (biodata == null) {
        return const Center(child: Text('Profile not found'));
      }

      return EditProfileTabBase(
        formKey: widget.formKey,
        children: [
          CustomTextField(
            title: 'Full Name',
            initialValue: biodata.fullName,
            required: true,
            onChanged: (value) {
              biodata.fullName = value;
              _editProfile(c, biodata);
            },
          ),
          CustomDatePicker(
            title: 'Birth Date',
            initialValue: biodata.birthDate,
            required: true,
            onChanged: (value) {
              biodata.birthDate = value;
              _editProfile(c, biodata);
            },
          ),
          CustomTextField(
            title: 'Birth Date',
            initialValue: biodata.birthDate.toString(),
            required: true,
            onChanged: (_) {},
          ),
          CustomDropdown(
            title: 'Gender',
            items: const ['Male', 'Female'],
            required: true,
            value: biodata.gender,
            onChanged: (value) {
              biodata.gender = value!;
              _editProfile(c, biodata);
            },
          ),
          CustomTextField(
            title: 'Email',
            initialValue: biodata.email,
            required: true,
            disabled: true,
            onChanged: (_) {},
          ),
          CustomTextField(
            title: 'Phone Number',
            initialValue: '${biodata.phoneNumber}',
            required: true,
            numeric: true,
            onChanged: (value) {
              biodata.phoneNumber = int.parse(value);
              _editProfile(c, biodata);
            },
          ),
          CustomDropdown(
            title: 'Education Level',
            items: const [
              'SD',
              'SMP',
              'SMA',
              'D1',
              'D2',
              'D3',
              'S1',
              'S2',
              'S3',
            ],
            value: biodata.educationLevel,
            onChanged: (value) {
              biodata.educationLevel = value!;
              _editProfile(c, biodata);
            },
          ),
          CustomDropdown(
            title: 'Marital Status',
            items: const [
              'Unmarried',
              'Married',
              'Divorced',
              'Widow/Widower',
            ],
            value: biodata.marriageStatus,
            onChanged: (value) {
              biodata.marriageStatus = value!;
              _editProfile(c, biodata);
            },
          ),
          CustomButton(
            text: 'Next',
            onTap: _onNext,
          ),
        ],
      );
    });
  }

  void _editProfile(EditProfileController controller, BiodataEntity biodata) {
    final profile = controller.profile.value!;
    profile.biodata = biodata;
    controller.editProfile(profile);
  }

  void _onNext() {
    if (!(widget.formKey.currentState?.validate() ?? false)) return;

    final c = Get.find<EditProfileController>();
    c.nextTab();
  }
}
