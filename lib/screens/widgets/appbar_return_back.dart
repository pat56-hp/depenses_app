import 'package:depenses/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AppBarReturnBack extends StatelessWidget {
  const AppBarReturnBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColor.buttonDarkColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SvgPicture.asset(
            'assets/icons/icon-left.svg',
            color: AppColor.buttonDarkColor,
          ),
        ),
      ),
    );
  }
}
