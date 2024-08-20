import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payuung/controllers/edit_profile_controller.dart';
import 'package:payuung/screens/edit_profile/tabs/address_tab.dart';
import 'package:payuung/screens/edit_profile/tabs/biodata_tab.dart';
import 'package:payuung/screens/edit_profile/tabs/company_tab.dart';
import 'package:payuung/widgets/custom_tab.dart';
import 'package:payuung/widgets/custom_tab_bar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with TickerProviderStateMixin {
  late final EditProfileController _editController;
  late final TabController _tabController;
  late final List<CustomTab> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      BiodataTab(formKey: GlobalKey<FormState>()),
      AddressTab(formKey: GlobalKey<FormState>()),
      CompanyTab(formKey: GlobalKey<FormState>()),
    ];
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() => setState(() {}));
    _editController = EditProfileController(tabController: _tabController.obs);
    Get.put<EditProfileController>(_editController);
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<EditProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.blueGrey),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Personal Information',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          CustomTabBar(
            controller: _tabController,
            tabs: _tabs,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: _tabs,
            ),
          ),
        ],
      ),
    );
  }
}
