import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';

class ButtonOtherLogin extends StatelessWidget {
  const ButtonOtherLogin(
      {super.key, required this.image, required this.onPress});

  final String image;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => onPress,
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
        child: Image.asset(
          image,
          width: 30,
          height: 30,
        ));
  }
}
