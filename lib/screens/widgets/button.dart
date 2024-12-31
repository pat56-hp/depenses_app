import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    this.buttonColor,
    this.labelColor,
    this.labelSize,
    this.icon,
  });

  final String label;
  final Color? buttonColor;
  final Color? labelColor;
  final double? labelSize;
  final VoidCallback onPressed;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(buttonColor),
        elevation: const WidgetStatePropertyAll(AppSize.elevated),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(
              vertical: AppSize.buttonPaddingVeritical,
              horizontal: AppSize.buttonPaddingHorizontal),
        ),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
        )),
      ),
      child: icon != null
          ? Row(
              children: [
                Icon(icon as IconData?),
                const SizedBox(
                  width: 5,
                ),
                text(
                    label: label,
                    color: labelColor ?? AppColor.lightTextColor,
                    fontSize: labelSize ?? AppSize.title),
              ],
            )
          : text(
              label: label,
              color: labelColor ?? AppColor.lightTextColor,
              fontSize: labelSize ?? AppSize.title),
    );
  }
}
