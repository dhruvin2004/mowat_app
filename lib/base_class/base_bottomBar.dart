import 'package:flutter/cupertino.dart';

import '../constants/utils.dart';
import '../res/color_res.dart';
import 'base_text.dart';

class BottomNavigationTabBarItem extends StatelessWidget {
  final List<BottomNavyBarItem> items;
  final double? customContainerHeight;
  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final MainAxisAlignment mainAxisAlignment;
  final ValueChanged onSelectItem;

  const BottomNavigationTabBarItem({
    Key? key,
    required this.items,
    this.customContainerHeight,
    this.selectedIndex = 0,
    this.backgroundColor,
    this.iconSize = 24,
    this.mainAxisAlignment = MainAxisAlignment.spaceAround,
    required this.onSelectItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: customContainerHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
          color: ColorRes.blackColor.withOpacity(0.1),
            offset: Offset(0,-10),
            blurRadius: 16,
      ),
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          var index = items.indexOf(item);
          return GestureDetector(
            onTap: () => onSelectItem(index),
            child: ItemWidget(
              item: item,
              isSelected: index == selectedIndex,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    required this.icon,
    required this.selectedIcon,
    required this.title,
  });

  final Widget icon;
  final Widget selectedIcon;
  final String title;
}

class ItemWidget extends StatelessWidget {
  final bool isSelected;
  final BottomNavyBarItem item;

  const ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isSelected ? item.selectedIcon : item.icon,
        BaseText(
          text: item.title,
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.center,
          fontSize: 14,
          color: isSelected ? ColorRes.primaryColor :ColorRes.textGreyColor,
        ),
      ],
    );
  }
}


