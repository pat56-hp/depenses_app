import 'package:depenses/screens/auth/controllers/forgot_controller.dart';
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
  final ForgotController _forgotController = Get.find<ForgotController>();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  late TextEditingController _passwordConfirmationController =
      TextEditingController();
  final arguments = Get.arguments;
  bool _passwordIsObscure = true;
  bool _confirmPasswordIsObscure = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text = arguments['email'];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
  }

  //Envoie des datas pour reinitialisation
  void sendToReset() {
    _forgotController.resetPassword(
      email: arguments['email'],
      password: _passwordController.text,
      passwordConfirmation: _passwordConfirmationController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(arguments['email']);

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
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.paddingHorizontal),
                child: Column(
                  children: [
                    title(
                        label: 'Réinitialisation du mot de passe',
                        size: AppSize.title),
                    spaceHeight(16.0),
                    subtitle(
                      label: 'Veuillez renseigner tous les champs',
                      extra: {'textAlign': TextAlign.center},
                    ),
                    spaceHeight(60.0),
                    Obx(() {
                      return InputWidget(
                        controller: _emailController,
                        hintText: "Adresse email",
                        prefixIcon: "assets/icons/envelope.svg",
                        value: arguments['email'] ?? '',
                        readOnly: true,
                        clickFunction: () {},
                        errorText:
                            _forgotController.resetEmailError.value.isNotEmpty
                                ? _forgotController.resetEmailError.value
                                : null,
                      );
                    }),
                    spaceHeight(22.0),
                    Stack(
                      children: [
                        Obx(() {
                          return InputWidget(
                            controller: _passwordController,
                            hintText: "Mot de passe",
                            prefixIcon: 'assets/icons/lock.svg',
                            obscureText: _passwordIsObscure,
                            errorText: _forgotController
                                    .resetPasswordError.value.isNotEmpty
                                ? _forgotController.resetPasswordError.value
                                : null,
                          );
                        }),
                        Positioned(
                          top: 18,
                          right: 14,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passwordIsObscure = !_passwordIsObscure;
                              });
                            },
                            child: SizedBox(
                              child: SvgPicture.asset(
                                _passwordIsObscure
                                    // ignore: dead_code
                                    ? 'assets/icons/eye.svg'
                                    : 'assets/icons/low-eye.svg',
                                color: AppColor.iconColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    spaceHeight(22.0),
                    Stack(
                      children: [
                        Obx(() {
                          return InputWidget(
                            controller: _passwordConfirmationController,
                            hintText: "Confirmation du mot de passe",
                            prefixIcon: 'assets/icons/lock.svg',
                            obscureText: _confirmPasswordIsObscure,
                            errorText: _forgotController
                                    .resetConfirmationError.value.isNotEmpty
                                ? _forgotController.resetConfirmationError.value
                                : null,
                          );
                        }),
                        Positioned(
                          top: 18,
                          right: 14,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _confirmPasswordIsObscure =
                                    !_confirmPasswordIsObscure;
                              });
                            },
                            child: SizedBox(
                              child: SvgPicture.asset(
                                _confirmPasswordIsObscure
                                    // ignore: dead_code
                                    ? 'assets/icons/eye.svg'
                                    : 'assets/icons/low-eye.svg',
                                color: AppColor.iconColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    spaceHeight(22.0),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(() {
                        return ButtonWidget(
                          label: 'Réinitiliser le mot de passe',
                          onPressed: () => sendToReset(),
                          buttonColor: AppColor.buttonLightColor,
                          loading: _forgotController.loadingReset.value,
                        );
                      }),
                    ),
                    spaceHeight(50.0),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      text(
                          label: 'Vous avez déjà un compte ?',
                          extra: {'fontWeight': FontWeight.w300}),
                      spaceWidth(4.0),
                      InkWell(
                          onTap: () => Get.offAllNamed('/login'),
                          child: text(
                              label: 'Connectez-vous',
                              extra: {'fontWeight': FontWeight.w600}))
                    ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
