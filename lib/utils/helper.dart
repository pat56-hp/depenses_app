import 'package:depenses/screens/widgets/button.dart';
import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Text buttonText({label, color}) {
  return Text(label, style: color);
}

Text largeTitle({label, color}) {
  return Text(label,
      style: TextStyle(
        color: color,
        fontSize: AppSize.largeTitle,
        fontWeight: FontWeight.bold,
      ));
}

Text title({label, color, size}) {
  return Text(label,
      style: TextStyle(
        color: color,
        fontSize: size ?? AppSize.title,
        fontWeight: FontWeight.bold,
      ));
}

Text subtitle({label, color, extra}) {
  return Text(
    label,
    style: TextStyle(
      color: color ?? AppColor.textColor,
      fontSize: AppSize.subtitle,
      fontWeight: extra?['fontWeight'] ?? FontWeight.w300,
    ),
    textAlign: extra?['textAlign'] ?? TextAlign.start,
  );
}

Text text({label, color, fontSize, extra}) {
  return Text(
    label,
    style: TextStyle(
        color: color ?? AppColor.textColor,
        fontSize: fontSize ?? AppSize.text,
        fontWeight: extra?['fontWeight'] ?? FontWeight.normal,
        decoration: TextDecoration.none),
    textAlign: extra?['textAlign'] ?? TextAlign.start,
  );
}

SizedBox spaceHeight(heigth) => SizedBox(height: heigth);

SizedBox spaceWidth(width) => SizedBox(width: width);

//Recuperation et affichage des erreurs 422 de l'api
void showErrors(errors) {
  String errorMessages = '';

  for (var entry in errors.entries) {
    // Vérifie que la clé est une String et que la valeur est une List contenant des String
    if (entry.key is String &&
        entry.value is List &&
        entry.value.isNotEmpty &&
        entry.value[0] is String) {
      String key = entry.key;
      String errorMessage = entry.value[0];

      errorMessages = '$errorMessages$key: $errorMessage \n';
    }
  }

  //Affichage du dialog
  alert('error', errorMessages);
}

//Dialog widget
void showDialogWidget(String title, String content) {
  Get.defaultDialog(
    backgroundColor: AppColor.backgroundColor,
    title: title,
    titlePadding: const EdgeInsets.symmetric(vertical: 15),
    titleStyle: const TextStyle(
      fontSize: AppSize.subtitle,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    //middleText: content,
    middleTextStyle: const TextStyle(
      fontSize: AppSize.text,
      color: AppColor.textColor,
    ),
    content: Column(
      children: [text(label: content)],
    ),
    confirm: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ButtonWidget(
          label: 'Fermer',
          labelSize: AppSize.text,
          verticalPadding: AppSize.buttonWidgetPaddingVertical,
          horizontalPadding: AppSize.buttonWidgetPaddingHorizontal,
          buttonColor: AppColor.buttonLightColor,
          onPressed: () => Get.back()),
    ),
    barrierDismissible:
        false, // Empêche de fermer le dialogue en cliquant à l'extérieur
  );
}

//Modal d'alert erreur ou succes
void alert(String type, String content) {
  Get.dialog(
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSize.buttonPaddingHorizontal),
          margin:
              const EdgeInsets.symmetric(horizontal: AppSize.paddingHorizontal),
          decoration: BoxDecoration(
              color: AppColor.backgroundColorWhite,
              borderRadius: BorderRadius.circular(AppSize.borderRadius)),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: Image.asset('assets/images/$type.png'),
              ),
              spaceHeight(22.0),
              text(
                  label: content,
                  fontSize: AppSize.subtitle,
                  extra: {'textAlign': TextAlign.center}),
              spaceHeight(18.0),
              ButtonWidget(
                  label: 'Fermer',
                  labelSize: AppSize.text,
                  verticalPadding: AppSize.buttonWidgetPaddingVertical,
                  horizontalPadding: AppSize.buttonWidgetPaddingHorizontal,
                  buttonColor: AppColor.buttonLightColor,
                  onPressed: () => Get.back()),
            ],
          ),
        ),
      ],
    ),
    name: type.toString(),
  );
}

//SnackBar widget pour erreur ou success
void showSnackBarWidget({
  String type = 'info',
  required String content,
}) {
  Color backgroundColor;
  Color contentColor;
  String title = 'Info';
  Icon icon;

  switch (type) {
    case 'error':
      backgroundColor = AppColor.inputBorderError;
      title = 'Erreur';
      contentColor = AppColor.lightTextColor;
      icon = const Icon(Icons.error, color: AppColor.lightTextColor);
      break;

    case 'success':
      backgroundColor = const Color.fromARGB(255, 13, 176, 34);
      title = 'Succès';
      contentColor = AppColor.lightTextColor;
      icon = const Icon(Icons.check_circle, color: AppColor.lightTextColor);
      break;

    default:
      backgroundColor = AppColor.backgroundColor;
      contentColor = AppColor.lightTextColor;
      icon = const Icon(Icons.info, color: AppColor.lightTextColor);
      break;
  }

  Get.snackbar(
    backgroundColor: backgroundColor,
    colorText: contentColor,
    icon: icon,
    title,
    content,
  );
}

String formatMontant(int montant) {
  return NumberFormat.currency(locale: 'fr_FR', symbol: '', decimalDigits: 0)
      .format(montant)
      .replaceAll('\u202F', ' ');
}
