import 'dart:async';
import 'dart:convert';

import 'package:depenses/core/routes/api_end_point.dart';
import 'package:depenses/core/services/api_service.dart';
import 'package:depenses/utils/helper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ForgotController extends GetxController {
  final RxBool loading = false.obs;
  final RxBool loadingCode = false.obs;
  final RxBool loadingReset = false.obs;
  final RxString userEmailError = ''.obs;
  final RxString resetEmailError = ''.obs;
  final RxString resetPasswordError = ''.obs;
  final RxString resetConfirmationError = ''.obs;

  void reset() {
    loading.value = false;
    loadingCode.value = false;
    loadingReset.value = false;
    userEmailError.value = '';
    resetEmailError.value = '';
    resetPasswordError.value = '';
    resetConfirmationError.value = '';
  }

  @override
  void onInit() {
    reset();
    print('Initialisation');
    super.onInit();
  }

  @override
  void onClose() {
    reset();
    print('Fermeture');
    super.onClose();
  }

  //Mot de passe oublié
  Future<void> forgot_password({String? email}) async {
    loading.value = true;

    await Future.delayed(const Duration(seconds: 1));

    //On verifie si l'adresse email n'est pas vide
    if (email!.isEmpty) {
      userEmailError.value = 'Veuillez renseigner votre adresse email';
      loading.value = false;
      return;
    }

    userEmailError.value = '';

    try {
      final response =
          await ApiService.post(ApiEndPoint.verifyEmail, {'email': email});

      if (response.statusCode == 200) {
        loading.value = false;

        showSnackBarWidget(
          type: 'success',
          content:
              'Le code de réinitialisation a été envoyé à l\'adresse email',
        );
        Get.toNamed('/verify_code', arguments: {'email': email});
      }
    } catch (e) {
      loading.value = false;
      print('######## Une erreur inattendue s\'est produite : ' + e.toString());
    }
  }

  //Verification du code envoyé à l'email
  Future<void> verifyCode({String? email, String? code}) async {
    loadingCode.value = true;

    await Future.delayed(const Duration(seconds: 1));

    //On verifie si le code n'est pas vide
    if (code!.isEmpty) {
      alert('error', "Veuillez renseigner le code reçu par mail");
      loadingCode.value = false;
      return;
    }

    try {
      final response = await ApiService.post(
          ApiEndPoint.verifyCode, {'email': email, 'code': code});

      loadingCode.value = false;
      Get.toNamed('/reset_password', arguments: {'email': email});
    } catch (e) {
      loadingCode.value = false;
      print('######## Une erreur inattendue s\'est produite : ' + e.toString());
    }
  }

  //Reinitialisation du code
  Future<void> resetPassword(
      {String? email, String? password, String? passwordConfirmation}) async {
    loadingReset.value = true;
    await Future.delayed(const Duration(seconds: 1));

    //On verifie si l'adresse email n'est pas vide
    if (email!.isEmpty) {
      resetEmailError.value = 'Veuillez renseigner votre adresse email';
      loadingReset.value = false;
      return;
    }

    if (password!.isEmpty) {
      resetPasswordError.value = 'Veuillez renseigner le nouveau mot de passe';
      loadingReset.value = false;
      return;
    }

    if (passwordConfirmation!.isEmpty) {
      resetPasswordError.value = 'Veuillez confirmer le nouveau mot de passe';
      loadingReset.value = false;
      return;
    }

    if (passwordConfirmation != password) {
      resetConfirmationError.value =
          'Le mot de passe passe n\'est pas conforme';
      loadingReset.value = false;
      return;
    }

    resetEmailError.value = '';
    resetPasswordError.value = '';
    resetConfirmationError.value = '';

    try {
      final response = await ApiService.post(ApiEndPoint.resetPassword, {
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation
      });

      final data = response.data;

      showSnackBarWidget(
        type: 'success',
        content: data['message'],
      );
      Get.offAllNamed('/login');

      print('######### data : $data');
    } catch (e) {
      loadingReset.value = false;
      print('######## Une erreur inattendue s\'est produite : ' + e.toString());
    }
  }
}
