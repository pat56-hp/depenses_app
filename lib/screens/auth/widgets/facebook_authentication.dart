import 'package:depenses/core/controllers/authController.dart';
import 'package:depenses/screens/auth/controllers/socialiteController.dart';
import 'package:depenses/screens/auth/widgets/ButtonOtherLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

class FacebookAuthentication extends StatefulWidget {
  const FacebookAuthentication({super.key});

  @override
  State<FacebookAuthentication> createState() => _FacebookAuthenticationState();
}

class _FacebookAuthenticationState extends State<FacebookAuthentication> {
  final SocialiteController _socialiteController = Get.put(
    SocialiteController(),
  );

  final AuthController _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ButtonOtherLogin(
          loading: _socialiteController.fbLoading.value,
          image: 'assets/images/facebook.png',
          onPress: () async {
            try {
              print('Facebook button is pressed');
              final UserCredential userCredential =
                  await _socialiteController.userSignWithFacebook();

              print('#########Socialite : ${userCredential.toString()}');
            } catch (e, stacktrace) {
              print('Erreur lors de la connexion Facebook : $e');
              print(stacktrace);
            }
          });
    });
  }
}
