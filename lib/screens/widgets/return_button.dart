import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ReturnButton extends StatelessWidget {
  const ReturnButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.back(),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.borderRadiusSmall),
            border: Border.all(color: AppColor.border)),
        child: SvgPicture.asset(
          'assets/icons/icon-left.svg',
          width: AppSize.smallIcon,
          height: AppSize.smallIcon,
        ),
      ),
    );
  }
}
