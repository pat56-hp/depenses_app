import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ConfigItem extends StatelessWidget {
  const ConfigItem(
      {super.key,
      required this.label,
      required this.icon,
      required this.link,
      required this.lenght,
      required this.index});

  final String label;
  final String icon;
  final String link;

  final int lenght;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                  color: AppColor.iconColor,
                  width: 20.0,
                  height: 20.0,
                ),
                spaceWidth(9.0),
                subtitle(label: label)
              ],
            ),
            SvgPicture.asset(
              'assets/icons/icon-right.svg',
              color: AppColor.iconColor,
              width: AppSize.icon,
              height: AppSize.icon,
            ),
          ],
        ),
        index + 1 != lenght
            ? Column(
                children: [
                  spaceHeight(20.0),
                  Container(
                    color: AppColor.configLine,
                    height: 1.0,
                  ),
                  spaceHeight(20.0)
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
