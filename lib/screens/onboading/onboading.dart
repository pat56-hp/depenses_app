import 'package:depenses/screens/widgets/button.dart';
import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Onboading extends StatelessWidget {
  const Onboading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSize.paddingHorizontal,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    SvgPicture.asset(
                      'assets/images/onboad_img.svg',
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.38,
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    title(label: "Suivie des dépenses", size: 35.0),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: subtitle(
                          label:
                              "Suivez vos dépenses et maitrisez votre bugdet au quotidien",
                          extra: {'textAlign': TextAlign.center}),
                    ),
                  ],
                )),
                SizedBox(
                  width: double.infinity,
                  child: ButtonWidget(
                    label: 'Commencer maintenant',
                    buttonColor: AppColor.buttonLightColor,
                    onPressed: () => Get.offAllNamed('/login'),
                  ),
                ),
                const SizedBox(
                  height: AppSize.paddingVertical,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
