import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavigationItem extends StatelessWidget {
  const NavigationItem(
      {super.key,
      required this.index,
      required this.selectedIndex,
      required this.label,
      required this.icon});

  final int index;
  final int selectedIndex;
  final String label;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      selectedIcon: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              height: AppSize.icon,
              width: AppSize.icon,
              color: selectedIndex == index
                  ? AppColor.textColor
                  : AppColor.iconColor,
            ),
            //spaceHeight(8.0),
            text(label: label, extra: {
              'fontweight':
                  selectedIndex == index ? FontWeight.w400 : FontWeight.w300
            })
          ],
        ),
      ),
      icon: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            SvgPicture.asset(
              icon,
              height: AppSize.icon,
              width: AppSize.icon,
              color: AppColor.iconColor,
            ),
            //spaceHeight(8.0),
            text(
                label: label,
                fontSize: 14.0,
                color: AppColor.iconColor,
                extra: {
                  'fontweight': FontWeight.w200,
                })
          ],
        ),
      ),
      label: 'label',
    );
  }
}
