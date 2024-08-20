import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payuung/controllers/edit_profile_controller.dart';
import 'package:payuung/entities/profile/company/company_entity.dart';
import 'package:payuung/screens/edit_profile/edit_profile_base.dart';
import 'package:payuung/widgets/custom_button.dart';
import 'package:payuung/widgets/custom_dropdown.dart';
import 'package:payuung/widgets/custom_tab.dart';
import 'package:payuung/widgets/custom_text_field.dart';

class CompanyTab extends CustomTab {
  const CompanyTab({super.key, required super.formKey});

  @override
  int getTabIndex() => 2;

  @override
  String getTabName() => 'Company';

  @override
  State<StatefulWidget> createState() => _CompanyTabState();
}

class _CompanyTabState extends State<CompanyTab> {
  @override
  Widget build(BuildContext context) {
    final c = Get.find<EditProfileController>();
    return Obx(() {
      final profile = c.profile.value;
      final company = profile?.company;

      if (company == null) {
        return const Center(child: Text('Profile not found'));
      }

      return EditProfileTabBase(
        formKey: widget.formKey,
        children: [
          CustomTextField(
            title: 'Company Name',
            initialValue: company.name,
            onChanged: (value) {
              company.name = value;
              _editProfile(c, company);
            },
          ),
          CustomTextField(
            title: 'Company Address',
            initialValue: company.address,
            onChanged: (value) {
              company.address = value;
              _editProfile(c, company);
            },
          ),
          CustomDropdown(
            title: 'Job Position',
            items: const ['Mobile Developer', 'Test', 'Other Test'],
            value: company.position,
            onChanged: (value) {
              company.position = value!;
              _editProfile(c, company);
            },
          ),
          CustomDropdown(
            title: 'Tenure',
            items: const ['1-3 Years', 'Test', 'Other Test'],
            value: company.tenure,
            onChanged: (value) {
              company.tenure = value!;
              _editProfile(c, company);
            },
          ),
          CustomDropdown(
            title: 'Income Type',
            items: const ['Salary', 'Test', 'Other Test'],
            value: company.incomeType,
            onChanged: (value) {
              company.incomeType = value!;
              _editProfile(c, company);
            },
          ),
          CustomDropdown(
            title: 'Yearly Gross Income',
            items: const ['10-30 Million', 'Test', 'Other Test'],
            value: company.yearlyGross,
            onChanged: (value) {
              company.yearlyGross = value!;
              _editProfile(c, company);
            },
          ),
          CustomDropdown(
            title: 'Bank Name',
            items: const ['Bank Independent', 'Test', 'Other Test'],
            value: company.bankName,
            onChanged: (value) {
              company.bankName = value!;
              _editProfile(c, company);
            },
          ),
          CustomTextField(
            title: 'Bank Account Number',
            initialValue: '${company.bankAccountNumber}',
            numeric: true,
            onChanged: (value) {
              company.bankAccountNumber = int.parse(value);
              _editProfile(c, company);
            },
          ),
          CustomTextField(
            title: 'Bank Account Name',
            initialValue: company.bankAccountName,
            onChanged: (value) {
              company.bankAccountName = value;
              _editProfile(c, company);
            },
          ),
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
                  text: 'Save',
                  onTap: _onSave,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  void _editProfile(EditProfileController controller, CompanyEntity company) {
    final profile = controller.profile.value!;
    profile.company = company;
    controller.editProfile(profile);
  }

  void _onBack() {
    final c = Get.find<EditProfileController>();
    c.previousTab();
  }

  void _onSave() {
    if (!(widget.formKey.currentState?.validate() ?? false)) return;

    final c = Get.find<EditProfileController>();
    c.saveProfile();
  }
}
