import 'package:depenses/core/controllers/authController.dart';
import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeTopBar extends StatefulWidget {
  const HomeTopBar({
    super.key,
  });

  @override
  State<HomeTopBar> createState() => _HomeTopBarState();
}

class _HomeTopBarState extends State<HomeTopBar> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(label: "Bienvenue", extra: {'fontWeight': FontWeight.w300}),
            Obx(() => subtitle(
                  label:
                      _authController.user.value?.name ?? 'Utilisateur inconnu',
                  extra: {'fontWeight': FontWeight.bold},
                )),
          ],
        ),
        InkWell(
          onTap: () => _authController.logout(),
          child: SvgPicture.asset(
            'assets/icons/power.svg',
            width: AppSize.icon,
            color: AppColor.iconColor,
          ),
        )
      ],
    );
  }
}
