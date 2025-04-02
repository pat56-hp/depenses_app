import 'package:depenses/core/controllers/authController.dart';
import 'package:depenses/screens/auth/socialite/socialite.dart';
import 'package:depenses/screens/widgets/button.dart';
import 'package:depenses/screens/widgets/input_widget.dart';
import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthController _authController = Get.find<AuthController>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _passwordIsObscure = true;

  // Envoie des datas pour le login
  void submitLogin() async {
    await _authController.login(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColorWhite,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSize.paddingHorizontal),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    title(label: 'Bienvenue', size: AppSize.title),
                    spaceHeight(16.0),
                    subtitle(label: 'Veuillez vous connecter pour commencer'),
                    spaceHeight(60.0),
                    Obx(() {
                      return InputWidget(
                        controller: _emailController,
                        hintText: "Adresse email",
                        prefixIcon: "assets/icons/envelope.svg",
                        errorText:
                            _authController.userEmailError.value.isNotEmpty
                                ? _authController.userEmailError.value
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
                            errorText: _authController
                                    .userPasswordError.value.isNotEmpty
                                ? _authController.userPasswordError.value
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
                    spaceHeight(20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => Get.toNamed('/forgot_password'),
                          child: subtitle(
                              label: 'Mot de passe oublié',
                              extra: {'textAlign': TextAlign.start}),
                        ),
                      ],
                    ),
                    spaceHeight(20.0),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(() {
                        return ButtonWidget(
                          label: 'Se connecter',
                          loading: _authController.loading.value,
                          onPressed: () {
                            /* Soumission du formulaire */
                            submitLogin();
                          },
                          buttonColor: AppColor.buttonLightColor,
                        );
                      }),
                    ),
                    spaceHeight(40.0),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 1,
                          color: AppColor.line,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          color: AppColor.backgroundColorWhite,
                          child: text(
                              label: 'ou continuer avec',
                              extra: {'fontWeight': FontWeight.w300}),
                        )
                      ],
                    ),
                    spaceHeight(40.0),
                    const Socialite(),
                    spaceHeight(40.0),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      text(
                          label: 'Pas encore inscris ?',
                          extra: {'fontWeight': FontWeight.w300}),
                      spaceWidth(4.0),
                      InkWell(
                          onTap: () => Get.toNamed('/register'),
                          child: text(
                              label: 'Inscrivez-vous',
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
