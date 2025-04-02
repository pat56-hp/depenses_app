import 'package:depenses/core/controllers/authController.dart';
import 'package:depenses/screens/auth/controllers/socialiteController.dart';
import 'package:depenses/screens/auth/widgets/ButtonOtherLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GithubAuthentication extends StatefulWidget {
  const GithubAuthentication({super.key});

  @override
  State<GithubAuthentication> createState() => _GithubAuthenticationState();
}

class _GithubAuthenticationState extends State<GithubAuthentication> {
  final SocialiteController _socialiteController =
      Get.put(SocialiteController());
  final AuthController _authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ButtonOtherLogin(
        image: 'assets/images/github.png',
        label: 'Github',
        loading: _socialiteController.gitLoading.value,
        onPress: () async {
          try {
            print('Github authentication started');
            final UserCredential userCredential =
                await _socialiteController.userSignWithGithub();
            print('Authentication successful: ${userCredential}');
          } catch (e) {
            print('Error during authentication: $e');
            _socialiteController.loadingFinish();
          }
        },
      );
    });
  }
}
