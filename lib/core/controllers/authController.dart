import 'dart:convert';

import 'package:depenses/core/routes/api_end_point.dart';
import 'package:depenses/core/services/api_service.dart';
import 'package:get/get.dart';
//import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();
  final _tokenKey = 'auth_token';
  final _userKey = 'user_data';

  RxBool loading = false.obs;
  RxString errors = ''.obs;
  final RxString userEmailError = ''.obs;
  final RxString userPasswordError = ''.obs;

  //Login utilisateur
  Future<void> login({String? email, String? password}) async {
    loading.value = true;

    //On verifie si les champs email et password ne sont pas vide
    if (!validateFields(email!, password!)) return;

    try {
      final response = await ApiService.post(
        ApiEndPoint.login,
        {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        //On cree la session
        final data = response.data;

        //Sauvegarde des infos dans le storage local
        await _storage.write(_tokenKey, data['access_token']);
        await _storage.write(_userKey, jsonEncode(data['user']));

        //user.value = User.fromJson(data['user']);

        printStorageContent();

        //Redirection vers la page home
        Get.offAllNamed('/home');
      }
    } catch (e) {
      loading.value = false;
      print('Une erreur s\'est produite : ${e.toString()}');
    }
  }

  //Register utilisateur
  Future<void> register() async {}

  //Logout utilisateur
  Future<void> logout() async {}

  //Restoration de la session de l'utilisateur
  Future<void> restoreSession() async {}

  bool validateFields(String email, String password) {
    bool isValid = true;

    userEmailError.value = '';
    userPasswordError.value = '';

    if (email.isEmpty) {
      userEmailError.value = 'Veuillez renseigner votre adresse email';
      loading.value = false;
      isValid = false;
    }

    if (password.isEmpty) {
      userPasswordError.value = 'Veuillez renseigner votre mot de passe';
      loading.value = false;
      isValid = false;
    }

    return isValid;
  }

  //Recuperation du token
  String? getToken() {
    return _storage.read(_tokenKey);
  }

  void printStorageContent() {
    print('################# Contenu du storage: ##################');
    print('Token: ${_storage.read(_tokenKey)}');
    print('User: ${_storage.read(_userKey)}');
    print('################# Fin ##################');
  }
}
