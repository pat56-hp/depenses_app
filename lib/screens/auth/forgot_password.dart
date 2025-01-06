import 'package:depenses/core/controllers/authController.dart';
import 'package:depenses/screens/auth/controllers/forgot_controller.dart';
import 'package:depenses/screens/widgets/button.dart';
import 'package:depenses/screens/widgets/input_widget.dart';
import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final ForgotController _forgotController = Get.find<ForgotController>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void sender() async {
      await _forgotController.forgot_password(email: _emailController.text);
    }

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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.paddingHorizontal),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  spaceHeight(60.0),
                  title(label: 'Mot de passe oublié ?', size: AppSize.title),
                  spaceHeight(16.0),
                  subtitle(
                    label:
                        'Ne vous inquiétez pas, nous vous enverrons des instructions pour la réinitialisation de votre mot de passe',
                    extra: {'textAlign': TextAlign.center},
                  ),
                  spaceHeight(60.0),
                  Obx(() {
                    return InputWidget(
                      controller: _emailController,
                      errorText:
                          _forgotController.userEmailError.value.isNotEmpty
                              ? _forgotController.userEmailError.value
                              : null,
                      hintText: "Adresse email",
                      prefixIcon: "assets/icons/envelope.svg",
                    );
                  }),
                  spaceHeight(22.0),
                  SizedBox(
                    width: double.infinity,
                    child: Obx(() {
                      return ButtonWidget(
                        label: 'Recevoir les instructions',
                        loading: _forgotController.loading.value,
                        onPressed: () => sender(),
                        buttonColor: AppColor.buttonLightColor,
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
