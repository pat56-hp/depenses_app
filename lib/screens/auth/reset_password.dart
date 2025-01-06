import 'package:depenses/screens/widgets/button.dart';
import 'package:depenses/screens/widgets/input_widget.dart';
import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final int codeLength = 6;
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  final arguments = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllers = List.generate(codeLength, (_) => TextEditingController());
    focusNodes = List.generate(codeLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllers.forEach((controller) => controller.dispose());
    focusNodes.forEach((focusNode) => focusNode.dispose());
  }

  void onTextChanged(String value, int index) {
    if (value.isNotEmpty && index < codeLength - 1) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  void onPaste(String pastedText) {
    for (int i = 0; i < pastedText.length; i++) {
      controllers[i].text = pastedText[i];
    }
    if (pastedText.length == codeLength) {
      focusNodes.last.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Container(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: AppColor.buttonDarkColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.asset(
                  'assets/icons/icon-left.svg',
                  color: AppColor.buttonDarkColor,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: AppColor.backgroundColorWhite,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSize.paddingHorizontal),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                spaceHeight(60.0),
                title(
                    label: 'Réinitialisation du mot de passe',
                    size: AppSize.title),
                spaceHeight(16.0),
                subtitle(
                  label: 'Nous avons envoyé un code de vérification à ',
                  extra: {'textAlign': TextAlign.center},
                ),
                subtitle(
                  label: arguments['email'] ?? 'Introuvable',
                  extra: {
                    'textAlign': TextAlign.center,
                    'fontWeight': FontWeight.bold
                  },
                ),
                spaceHeight(60.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(codeLength, (index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 9),
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: InputWidget(
                        hintText: "",
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        onChanged: (value) => onTextChanged(value, index),
                      ),
                    );
                  }),
                ),
                spaceHeight(22.0),
                SizedBox(
                  width: double.infinity,
                  child: ButtonWidget(
                    label: 'Continuer',
                    onPressed: () {},
                    buttonColor: AppColor.buttonLightColor,
                  ),
                ),
                spaceHeight(50.0),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  text(
                      label: 'Vous n\'avez pas reçu de code ?',
                      extra: {'fontWeight': FontWeight.w300}),
                  spaceWidth(4.0),
                  InkWell(
                      onTap: () {},
                      child: text(
                          label: 'Renvoyer',
                          extra: {'fontWeight': FontWeight.w600}))
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
