import 'package:depenses/screens/widgets/loading_circular_progress.dart';
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
    this.verticalPadding,
    this.horizontalPadding,
    this.loading,
    this.border = false,
    this.borderColor,
  });

  final String label;
  final Color? buttonColor;
  final Color? labelColor;
  final double? labelSize;
  final double? verticalPadding;
  final double? horizontalPadding;
  final VoidCallback onPressed;
  final Icon? icon;
  final bool? loading;

  final bool border;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (loading ?? false) ? null : onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(buttonColor),
        elevation: const WidgetStatePropertyAll(AppSize.elevated),
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(
              vertical: verticalPadding ?? AppSize.buttonPaddingVeritical,
              horizontal: horizontalPadding ?? AppSize.buttonPaddingHorizontal),
        ),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          side: border
              ? BorderSide(color: borderColor ?? AppColor.border)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
        )),
      ),
      child: (loading ?? false)
          ? const LoadingCircularProgress(
              color: AppColor.backgroundColorWhite,
            )
          : icon != null
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
