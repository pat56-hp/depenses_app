import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(label: "Bienvenue", extra: {'fontWeight': FontWeight.w300}),
            subtitle(
                label: "Patrick Kouassi",
                extra: {'fontWeight': FontWeight.bold})
          ],
        ),
        SvgPicture.asset(
          'assets/icons/power.svg',
          width: AppSize.icon,
          color: AppColor.iconColor,
        )
      ],
    );
  }
}
