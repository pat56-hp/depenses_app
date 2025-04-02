import 'package:depenses/core/controllers/authController.dart';
import 'package:depenses/screens/widgets/appbar_return_back.dart';
import 'package:depenses/screens/widgets/button.dart';
import 'package:depenses/screens/widgets/input_widget.dart';
import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _passwordIsObscure = true;
  final AuthController _authController = Get.find<AuthController>();
  late TextEditingController _userNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Envoie des datas pour le register
    void sender() async {
      await _authController.register(
        name: _userNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        type: 'mobile',
      );
    }

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColor.backgroundColorWhite,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: const AppBarReturnBack(),
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSize.paddingHorizontal),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      title(label: 'Création de compte', size: AppSize.title),
                      spaceHeight(16.0),
                      subtitle(
                          label:
                              'Inscrivez-vous en remplissant tous les champs'),
                      spaceHeight(60.0),
                      InputWidget(
                        controller: _userNameController,
                        hintText: "Nom & prénom(s)",
                        prefixIcon: "assets/icons/user.svg",
                      ),
                      spaceHeight(22.0),
                      InputWidget(
                        controller: _emailController,
                        hintText: "Adresse email",
                        prefixIcon: "assets/icons/envelope.svg",
                      ),
                      spaceHeight(22.0),
                      Stack(
                        children: [
                          InputWidget(
                            controller: _passwordController,
                            hintText: "Mot de passe",
                            prefixIcon: 'assets/icons/lock.svg',
                            obscureText: _passwordIsObscure,
                          ),
                          Positioned(
                            top: 18,
                            right: 14,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _passwordIsObscure = !_passwordIsObscure;
                                  print('is click : $_passwordIsObscure');
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
                      SizedBox(
                        width: double.infinity,
                        child: Obx(() {
                          return ButtonWidget(
                            label: 'S\'inscrire',
                            loading: _authController.loading.value,
                            onPressed: () => sender(),
                            buttonColor: AppColor.buttonLightColor,
                          );
                        }),
                      ),
                      spaceHeight(50.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            text(
                                label: 'Vous avez déjà un compte ?',
                                extra: {'fontWeight': FontWeight.w300}),
                            spaceWidth(4.0),
                            InkWell(
                                onTap: () => Get.back(),
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
        ));
  }
}
