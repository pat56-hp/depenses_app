import 'dart:async';
import 'dart:convert';

import 'package:depenses/core/routes/api_end_point.dart';
import 'package:depenses/core/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ForgotController extends GetxController {
  final RxBool loading = false.obs;
  final RxString userEmailError = ''.obs;

  void reset() {
    loading.value = false;
    userEmailError.value = '';
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

        Get.toNamed('/reset_password', arguments: {'email': email});
      }
    } catch (e) {
      loading.value = false;
      print('######## Une erreur inattendue s\'est produite : ' + e.toString());
    }
  }
}
