import 'package:depenses/screens/widgets/loadingCircularProgress.dart';
import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';

class ButtonOtherLogin extends StatelessWidget {
  const ButtonOtherLogin(
      {super.key,
      required this.image,
      required this.onPress,
      this.loading = false,
      this.label});

  final String image;
  final VoidCallback onPress;
  final bool? loading;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPress,
        style: const ButtonStyle(
          elevation: WidgetStatePropertyAll(0),
          backgroundColor:
              WidgetStatePropertyAll(AppColor.backgroundColorWhite),
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: 25,
              vertical: AppSize.buttonPaddingVeritical,
            ),
          ),
          side: WidgetStatePropertyAll(
              BorderSide(color: AppColor.otherBorderColor)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(AppSize.borderRadius)))),
        ),
        child: loading == false
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    image,
                    width: 30,
                    height: 30,
                  ),
                  if (label != null) ...[
                    spaceWidth(10.0),
                    text(
                        label: label,
                        fontSize: 15.0,
                        extra: {'fontWeight': FontWeight.w300})
                  ] else
                    const SizedBox.shrink(),
                ],
              )
            : const LoadingCircularProgress(
                color: AppColor.secondaryColor,
                size: 25.0,
              ));
  }
}
