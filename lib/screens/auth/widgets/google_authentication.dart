import 'package:depenses/core/controllers/authController.dart';
import 'package:depenses/screens/auth/controllers/socialiteController.dart';
import 'package:depenses/screens/auth/widgets/ButtonOtherLogin.dart';
import 'package:depenses/utils/helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoogleAuthentication extends StatefulWidget {
  const GoogleAuthentication({super.key});

  @override
  State<GoogleAuthentication> createState() => _GoogleAuthenticationState();
}

class _GoogleAuthenticationState extends State<GoogleAuthentication> {
  final SocialiteController _socialiteController = Get.put(
    SocialiteController(),
  );
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ButtonOtherLogin(
        image: 'assets/images/google.png',
        loading: _socialiteController.googleLoading.value,
        label: 'Google',
        onPress: () async {
          try {
            final UserCredential userCredential =
                await _socialiteController.userSignWithGoogle();

            await _authController.register(
                email: userCredential.user!.email,
                password: userCredential.user!.email,
                name: userCredential.user!.displayName,
                type: 'google');
          } catch (e) {
            _socialiteController.loadingFinish();
            showSnackBarWidget(
              type: 'error',
              content: 'Une erreur s\'est produite, veuillez rééssayer svp.',
            );
          }
        },
      );
    });
    ;
  }
}
