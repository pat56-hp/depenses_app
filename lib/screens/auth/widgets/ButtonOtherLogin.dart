import 'package:depenses/screens/widgets/loadingCircularProgress.dart';
import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';

class ButtonOtherLogin extends StatelessWidget {
  const ButtonOtherLogin(
      {super.key,
      required this.image,
      required this.onPress,
      this.loading = false});

  final String image;
  final VoidCallback onPress;
  final bool? loading;

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
            ? Image.asset(
                image,
                width: 30,
                height: 30,
              )
            : const LoadingCircularProgress(
                color: AppColor.secondaryColor,
              ));
  }
}
