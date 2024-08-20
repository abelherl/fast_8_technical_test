import 'dart:io';

import 'package:flutter/material.dart';
import 'package:payuung/screens/dashboard/dashboard_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:payuung/constants/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final _panelController = PanelController();
  final _isOpened = ValueNotifier(false);

  @override
  void initState() {
    _tabController = TabController(
      length: 7,
      vsync: this,
      animationDuration: Duration.zero,
    );
    _tabController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        minHeight: Platform.isIOS ? 135 : 120,
        maxHeight: 300,
        color: Colors.transparent,
        boxShadow: const [],
        backdropEnabled: true,
        controller: _panelController,
        onPanelOpened: () => _isOpened.value = true,
        onPanelClosed: () => _isOpened.value = false,
        panel: _NavBar(_tabController, _panelController, _isOpened),
        body: _TabView(_tabController),
      ),
    );
  }
}
class _TabView extends StatelessWidget {
  const _TabView(this.tabController);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Constants.primaryColor),
        TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            DashboardScreen(),
            Placeholder(),
            Placeholder(),
            Placeholder(),
            Placeholder(),
            Placeholder(),
            Placeholder(),
          ],
        ),
      ],
    );
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar(this.tabController, this.panelController, this.isOpened);

  final TabController tabController;
  final PanelController panelController;
  final ValueNotifier<bool> isOpened;

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(18);
    const borderColor = Colors.black12;

    return Stack(
      children: [
        Transform.translate(
          offset: const Offset(0, 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: radius,
                topRight: radius,
              ),
              border: Border.all(color: borderColor),
              color: Colors.white,
            ),
            child: Transform.translate(
              offset: const Offset(0, -8),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.4,
                ),
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _NavBarItem(
                    index: 0,
                    tabController: tabController,
                    panelController: panelController,
                    title: 'Dashboard',
                    icon: Icons.home_outlined,
                  ),
                  _NavBarItem(
                    index: 1,
                    tabController: tabController,
                    panelController: panelController,
                    title: 'Search',
                    icon: Icons.search_outlined,
                  ),
                  _NavBarItem(
                    index: 2,
                    tabController: tabController,
                    panelController: panelController,
                    title: 'Cart',
                    icon: Icons.shopping_cart_outlined,
                  ),
                  _NavBarItem(
                    index: 3,
                    tabController: tabController,
                    panelController: panelController,
                    title: 'Transactions',
                    icon: Icons.history_outlined,
                  ),
                  _NavBarItem(
                    index: 4,
                    tabController: tabController,
                    panelController: panelController,
                    title: 'Vouchers',
                    icon: Icons.discount_outlined,
                  ),
                  _NavBarItem(
                    index: 5,
                    tabController: tabController,
                    panelController: panelController,
                    title: 'Shipping Address',
                    icon: Icons.local_shipping_outlined,
                  ),
                  _NavBarItem(
                    index: 6,
                    tabController: tabController,
                    panelController: panelController,
                    title: 'Friend List',
                    icon: Icons.people_outline,
                  ),
                ],
              ),
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: isOpened,
          builder: (_, value, __) {
            final icon =
                value ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up;
            return Align(
              alignment: Alignment.topCenter,
              child: IconButton(
                onPressed: () => _onPressed(value),
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: borderColor),
                    color: Colors.white,
                  ),
                  child: Icon(icon, color: Colors.blueGrey),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _onPressed(bool value) {
    isOpened.value = !value;
    if (panelController.isPanelOpen) {
      panelController.close();
    } else {
      panelController.open();
    }
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.index,
    required this.tabController,
    required this.panelController,
    required this.title,
    required this.icon,
  });

  final int index;
  final TabController tabController;
  final PanelController panelController;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final isSelected = index == tabController.index;
    final color = isSelected ? Constants.primaryColor : Colors.blueGrey;
    return InkWell(
      onTap: () => _onPressed(),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: color),
          ),
        ],
      ),
    );
  }

  void _onPressed() {
    tabController.index = index;
    panelController.close();
  }
}
