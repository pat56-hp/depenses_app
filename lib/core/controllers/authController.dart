import 'dart:async';
import 'dart:convert';

import 'package:depenses/core/models/user.dart';
import 'package:depenses/core/routes/api_end_point.dart';
import 'package:depenses/core/services/api_service.dart';
import 'package:depenses/screens/auth/controllers/socialiteController.dart';
import 'package:depenses/utils/helper.dart';
import 'package:get/get.dart';
//import 'package:dio/dio.dart' as dio;
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();
  final _tokenKey = 'auth_token';
  final _userKey = 'user_data';

  final RxBool loading = false.obs;
  final RxString errors = ''.obs;
  final Rx<User?> user = Rx<User?>(null);
  final RxString userEmailError = ''.obs;
  final RxString userPasswordError = ''.obs;

  final SocialiteController socialiteController =
      Get.put(SocialiteController());

  void reset() {
    loading.value = false;
    userEmailError.value = '';
    userPasswordError.value = '';
    errors.value = '';
  }

  @override
  void onInit() {
    super.onInit();
    reset();
    _loadUserFromStorage();
    print('Initialisation');
  }

  @override
  void onClose() {
    reset();
    print('Fermeture');
    super.onClose();
  }

  void _loadUserFromStorage() {
    final storedUser = _storage.read(_userKey);
    if (storedUser != null) {
      user.value = User.fromJson(jsonDecode(storedUser));
    }
  }

  //Login utilisateur
  Future<void> login({String? email, String? password}) async {
    loading.value = true;

    //On verifie si les champs email et password ne sont pas vide
    if (!validateFields(email.toString(), password.toString())) return;

    userEmailError.value = '';
    userPasswordError.value = '';

    try {
      final response = await ApiService.post(
        ApiEndPoint.login,
        {'email': email.toString(), 'password': password.toString()},
      );

      if (response.statusCode == 200) {
        //On cree la session
        final data = response.data;

        //print('#############');
        //print("#### data access_token : $data['user']");

        //Sauvegarde des infos dans le storage local
        await _storage.write(_tokenKey, data['access_token']);
        await _storage.write(_userKey, jsonEncode(data['user']));

        user.value = User.fromJson(data['user']);

        print('User : ${user.value?.toJson()}');

        //printStorageContent();

        showSnackBarWidget(
            type: 'success',
            content: 'Content de vous revoir 😃 ${user.value!.name}');

        //Redirection vers la page home
        Get.offAllNamed('/navigation');
      }
    } catch (e) {
      loading.value = false;
      print('######## Une erreur inattendue s\'est produite : $e');
    }
  }

  //Register utilisateur
  Future<void> register(
      {String? name, String? email, String? password, String? type}) async {
    loading.value = true;

    await Future.delayed(const Duration(seconds: 1));

    try {
      final response = await ApiService.post(ApiEndPoint.register,
          {'name': name, 'email': email, 'password': password, 'type': type});

      /* print('####### Response : ${response.toString()}');
      return;
      return; */
      if (response.statusCode == 200) {
        final data = response.data;

        await _storage.write(_tokenKey, data['access_token']);
        await _storage.write(_userKey, jsonEncode(data['user']));

        user.value = User.fromJson(data['user']);

        //printStorageContent();

        //Arret du loading sur les RS
        socialiteController.loadingFinish();

        //Redirection vers la page home
        Get.offAllNamed('/navigation');
      }
    } catch (e) {
      loading.value = false;
      socialiteController.loadingFinish();
      print('######## Une erreur inattendue s\'est produite : $e');
    }
  }

  //Logout utilisateur
  Future<void> logout() async {
    try {
      clearSession();
      Get.offAllNamed('/login');
    } catch (e) {
      print("Une erreur est survenue lors de la déconnexion : $e");
      alert('error', 'Une erreur est survenue lors de la déconnexion');
    }
  }

  Future<void> clearSession() async {
    try {
      await _storage.remove(_userKey);
      await _storage.remove(_tokenKey);
      user.value = null;
    } catch (e) {
      print("Une erreur est survenue lors de la déconnexion : $e");
    }
  }

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

  //Restoration de la session de l'utilisateur
  Future<void> restoreSession() async {
    try {
      final token = getToken();
      final userData = _storage.read(_userKey);

      printStorageContent();

      //Si le token & les data user existent
      //On recupere les informations dans le local et on le redirige vers la navigation (Home)
      if (token != null && userData != null) {
        user.value = User.fromJson(jsonDecode(userData));
        Get.offAllNamed('/navigation');
      } else {
        //On affiche un message d'erreur et interromp la session
        showSnackBarWidget(
          type: 'error',
          content:
              'Votre session a été interrompue ! Veuillez vous connecter svp.',
        );

        throw new Exception('Session expirée');
      }
    } catch (e) {
      print('Erreur lors de la restoration de la session : $e');
      clearSession();
      Get.offAllNamed('/onboading');
    }
  }

  void printStorageContent() {
    print('################# Contenu du storage: ##################');
    print('Token: ${_storage.read(_tokenKey)}');
    print('User: ${_storage.read(_userKey)}');
    print('################# Fin ##################');
  }

  void initAuthState() {
    Timer(const Duration(seconds: 6), () async {
      await restoreSession();
    });
  }
}
