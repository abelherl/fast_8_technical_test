import 'package:flutter/material.dart';
import 'package:payuung/constants/constants.dart';
import 'package:payuung/widgets/custom_tab.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.controller,
    required this.tabs,
  });

  final TabController controller;
  final List<CustomTab> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      color: Colors.white,
      child: Row(
        children: tabs
            .map((tab) => _TabBarItem(tab: tab, tabController: controller))
            .toList(),
      ),
    );
  }
}

class _TabBarItem extends StatelessWidget {
  const _TabBarItem({required this.tab, required this.tabController});

  final CustomTab tab;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final index = tab.getTabIndex();
    final title = tab.getTabName();

    final indexIsOver = tabController.index >= index;
    final isStart = index == 0;
    final isEnd = index == tabController.length - 1;
    final isBetween = !isStart && !isEnd;

    final color = _getColor(indexIsOver);
    final stepNumber = (index + 1).toStringAsFixed(0);
    final flex = isBetween ? 3 : 2;

    return Expanded(
      flex: flex,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: isStart ? 4 : 0,
              right: isEnd ? 4 : 0,
            ),
            child: Row(
              children: [
                _TabBarItemLine(isVisible: !isStart, color: color),
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => _onTap(index),
                  child: CircleAvatar(
                    backgroundColor: color,
                    radius: 16,
                    child: Text(
                      stepNumber,
                      style: Constants.styleBody2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                _TabBarItemLine(isVisible: !isEnd, color: color),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (!isStart) const Spacer(),
              Text(
                title,
                style: Constants.styleBody2.copyWith(
                  color: Constants.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              if (!isEnd) const Spacer(),
            ],
          ),
        ],
      ),
    );
  }

  void _onTap(int index) {
    tabController.animateTo(index);
  }

  Color _getColor(bool indexIsOver) => indexIsOver
      ? Constants.primaryColor
      : Constants.primaryColorLight;
}

class _TabBarItemLine extends StatelessWidget {
  const _TabBarItemLine({
    required this.isVisible,
    required this.color,
  });

  final bool isVisible;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (!isVisible) return Container();

    return Expanded(
      child: Container(
        height: 2,
        color: color,
      ),
    );
  }
}
