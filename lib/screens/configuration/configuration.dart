import 'package:depenses/core/controllers/authController.dart';
import 'package:depenses/screens/configuration/controller/profile_controller.dart';
import 'package:depenses/screens/configuration/widget/config_item.dart';
import 'package:depenses/screens/widgets/button.dart';
import 'package:depenses/screens/widgets/input_widget.dart';
import 'package:depenses/utils/colors.dart';
import 'package:depenses/utils/helper.dart';
import 'package:depenses/utils/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Configuration extends StatefulWidget {
  const Configuration({super.key});

  @override
  State<Configuration> createState() => _ConfigurationState();
}

class _ConfigurationState extends State<Configuration> {
  final ProfileController _profileController = Get.put(ProfileController());
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = _authController.user.value!.name.toString();
    _emailController.text = _authController.user.value!.email.toString();
  }

  @override
  Widget build(BuildContext context) {
    //Soumission du formulaire pour le profil
    Future<void> saveProfil() async {
      final response =
          await _profileController.updateProfile(name: _nameController.text);

      if (response) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }
    }

    //Soumission du formulaire pour le mot de passe
    Future<void> updatePassword() async {
      final response = await _profileController.updatePassword(
        currentPassword: _passwordController.text,
        newPassword: _newPasswordController.text,
        confirmPassword: _passwordConfirmationController.text,
      );

      if (response) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      }
    }

    // ----------------------------------------------------------------
    // Modification de profil
    void profileSetting() {
      Get.bottomSheet(
        backgroundColor: AppColor.backgroundColorWhite,
        Padding(
          padding: const EdgeInsets.all(AppSize.paddingVertical),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 4,
                  width: 50,
                  decoration: BoxDecoration(
                      color: AppColor.inputBorderActive,
                      borderRadius: BorderRadius.circular(8)),
                ),
                spaceHeight(25.0),
                title(label: 'Modifier mon profil', size: AppSize.title),
                spaceHeight(25.0),
                Obx(() {
                  return InputWidget(
                    hintText: "Nom & prénom(s)",
                    prefixIcon: "assets/icons/user.svg",
                    controller: _nameController,
                    errorText: _profileController.nameError.value.isNotEmpty
                        ? _profileController.nameError.value
                        : null,
                  );
                }),
                spaceHeight(22.0),
                InputWidget(
                  hintText: "Adresse email",
                  prefixIcon: "assets/icons/envelope.svg",
                  readOnly: true,
                  controller: _emailController,
                ),
                spaceHeight(20.0),
                SizedBox(
                    width: double.infinity,
                    child: Obx(() {
                      return ButtonWidget(
                        loading: _profileController.loading.value,
                        label: 'Enregistrer',
                        onPressed: () {
                          /* Soumission du formulaire */
                          saveProfil();
                        },
                        buttonColor: AppColor.buttonLightColor,
                      );
                    })),
              ],
            ),
          ),
        ),
      );
    }

    // ----------------------------------------------------------------
    // Modification du mot de passe
    void passwordSetting() {
      Get.bottomSheet(
        backgroundColor: AppColor.backgroundColorWhite,
        Padding(
          padding: const EdgeInsets.all(AppSize.paddingVertical),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 4,
                  width: 50,
                  decoration: BoxDecoration(
                      color: AppColor.inputBorderActive,
                      borderRadius: BorderRadius.circular(8)),
                ),
                spaceHeight(25.0),
                title(label: 'Modifier mon mot de passe', size: AppSize.title),
                spaceHeight(25.0),
                Stack(
                  children: [
                    Obx(() {
                      return InputWidget(
                        controller: _passwordController,
                        hintText: "Mot de passe actuel",
                        prefixIcon: 'assets/icons/lock.svg',
                        obscureText: _profileController.passwordIsObscure.value,
                        errorText:
                            _profileController.passwordError.value.isNotEmpty
                                ? _profileController.passwordError.value
                                : null,
                      );
                    }),
                    Positioned(
                      top: 18,
                      right: 14,
                      child: GestureDetector(
                        onTap: () =>
                            _profileController.passwordIsObscure.toggle(),
                        child: SizedBox(
                          child: Obx(() {
                            return SvgPicture.asset(
                              _profileController.passwordIsObscure.value
                                  // ignore: dead_code
                                  ? 'assets/icons/eye.svg'
                                  : 'assets/icons/low-eye.svg',
                              color: AppColor.iconColor,
                            );
                          }),
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
                        controller: _newPasswordController,
                        hintText: "Nouveau mot de passe",
                        prefixIcon: 'assets/icons/lock.svg',
                        obscureText:
                            _profileController.newPasswordIsObscure.value,
                        errorText:
                            _profileController.passwordError.value.isNotEmpty
                                ? _profileController.passwordError.value
                                : null,
                      );
                    }),
                    Positioned(
                      top: 18,
                      right: 14,
                      child: GestureDetector(
                        onTap: () =>
                            _profileController.newPasswordIsObscure.toggle(),
                        child: SizedBox(
                          child: Obx(() {
                            return SvgPicture.asset(
                              _profileController.newPasswordIsObscure.value
                                  // ignore: dead_code
                                  ? 'assets/icons/eye.svg'
                                  : 'assets/icons/low-eye.svg',
                              color: AppColor.iconColor,
                            );
                          }),
                        ),
                      ),
                    )
                  ],
                ),
                spaceHeight(22.0),
                Obx(() {
                  return InputWidget(
                    controller: _passwordConfirmationController,
                    hintText: "Confirmation du mot de passe",
                    prefixIcon: 'assets/icons/lock.svg',
                    obscureText: true,
                    errorText: _profileController
                            .resetConfirmationError.value.isNotEmpty
                        ? _profileController.resetConfirmationError.value
                        : null,
                  );
                }),
                spaceHeight(20.0),
                SizedBox(
                    width: double.infinity,
                    child: Obx(() {
                      return ButtonWidget(
                        loading: _profileController.loading.value,
                        label: 'Enregistrer',
                        onPressed: () {
                          /* Soumission du formulaire */
                          updatePassword();
                        },
                        buttonColor: AppColor.buttonLightColor,
                      );
                    })),
              ],
            ),
          ),
        ),
      );
    }

    final List<Map<dynamic, dynamic>> configItem = [
      //{"icon": "assets/icons/briefcase.svg", "name": "Catégories", "link": ""},
      {
        "icon": "assets/icons/user.svg",
        "name": "Mon profil",
        "link": profileSetting
      },
      {
        "icon": "assets/icons/lock.svg",
        "name": "Modifier mon mot de passe",
        "link": passwordSetting
      },
      {
        "icon": "assets/icons/exit.svg",
        "name": "Me déconnecter",
        "link": () => _authController.logout()
      },
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: text(
          label: 'Paramètres',
          fontSize: AppSize.title,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSize.paddingHorizontal),
          child: Center(
            child: Container(
                //height: 200,
                decoration: BoxDecoration(
                  color: AppColor.backgroundColorWhite,
                  borderRadius: BorderRadius.circular(AppSize.borderRadius),
                ),
                padding: const EdgeInsets.all(AppSize.paddingHorizontal),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: configItem.length,
                    itemBuilder: (context, index) => (ConfigItem(
                          lenght: configItem.length,
                          index: index,
                          label: configItem[index]["name"].toString(),
                          icon: configItem[index]["icon"].toString(),
                          link: configItem[index]["link"],
                        )))),
          ),
        ),
      ),
    );
  }
}
