import 'package:depenses/core/controllers/authController.dart';
import 'package:depenses/screens/auth/controllers/socialiteController.dart';
import 'package:depenses/screens/auth/widgets/ButtonOtherLogin.dart';
import 'package:depenses/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Socialite extends StatefulWidget {
  const Socialite({super.key});

  @override
  State<Socialite> createState() => _SocialiteState();
}

class _SocialiteState extends State<Socialite> {
  final SocialiteController _socialiteController = Get.put(
    SocialiteController(),
  );
  final AuthController _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonOtherLogin(image: 'assets/images/facebook.png', onPress: () {}),
        ButtonOtherLogin(image: 'assets/images/github.png', onPress: () {}),
        Obx(() {
          return ButtonOtherLogin(
            image: 'assets/images/google.png',
            loading: _socialiteController.googleLoading.value,
            onPress: () async {
              try {
                print('is pressed');

                final UserCredential userCredential =
                    await _socialiteController.userSignWithGoogle();

                print('#########Socialite : ${userCredential.toString()}');
                await _authController.register(
                    email: userCredential.user!.email,
                    password: userCredential.user!.email,
                    name: userCredential.user!.displayName,
                    type: 'google');
              } catch (e) {
                _socialiteController.loadingFinish();
                print('Error : $e');
                showSnackBarWidget(
                  type: 'error',
                  content:
                      'Une erreur s\'est produite, veuillez rééssayer svp.',
                );
              }
            },
          );
        }),
      ],
    );
  }
}
