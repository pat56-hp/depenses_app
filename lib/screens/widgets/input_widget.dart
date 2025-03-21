import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputWidget extends StatelessWidget {
  const InputWidget(
      {super.key,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.sizeIcon,
      this.obscureText,
      this.hintTextColor,
      this.background,
      this.controller,
      this.errorText,
      this.value,
      this.readOnly = false,
      this.clickFunction,
      this.focusNode,
      this.textAlign,
      this.maxLength,
      this.onChanged,
      this.keyboardType});

  final bool? obscureText;
  final Function? clickFunction;
  final String hintText;
  final String? prefixIcon;
  final String? suffixIcon;
  final double? sizeIcon;
  final Color? background;
  final Color? hintTextColor;
  final String? errorText;
  final String? value;
  final bool readOnly;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      maxLength: maxLength,
      textAlign: textAlign ?? TextAlign.start,
      onChanged: onChanged,
      readOnly: readOnly,
      keyboardType: keyboardType ?? TextInputType.text,
      onTap: () {
        if (readOnly == true && clickFunction != null) {
          clickFunction!();
        }
      },
      obscureText: obscureText ?? false,
      cursorColor: AppColor.secondaryColor,
      style: const TextStyle(color: AppColor.textColor, fontSize: AppSize.text),
      decoration: InputDecoration(
        counterText: "",
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 5, vertical: AppSize.paddingVertical),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintTextColor ?? AppColor.inputPlaceholderColor,
          fontSize: AppSize.placeholder,
        ),
        // Bordure inactive
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
        ),

        // Bordure active
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColor.inputBorderActive, width: 1),
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
        ),

        // Bordure d'erreur
        errorBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColor.inputBorderError, width: 1),
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
        ),
        errorText: errorText,
        errorStyle: const TextStyle(fontSize: AppSize.placeholder),

        // Bordure quand il y a une erreur et que le champ est actif
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: AppColor.inputBorderError, width: 1),
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
        ),
        fillColor: background ?? AppColor.inputColor,
        filled: true,
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  prefixIcon!,
                  color: AppColor.iconColor,
                ),
              )
            : null,
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: SvgPicture.asset(
                  suffixIcon!,
                  color: AppColor.iconColor,
                  width: sizeIcon ?? AppSize.icon,
                  height: sizeIcon ?? AppSize.icon,
                ),
              )
            : null,
      ),
    );
  }
}
