import 'package:depenses/core/controllers/authController.dart';
import 'package:depenses/core/models/user.dart';
import 'package:depenses/core/routes/api_end_point.dart';
import 'package:depenses/core/services/api_service.dart';
import 'package:depenses/utils/helper.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final RxBool loading = false.obs;
  final RxString userName = ''.obs;
  final RxString nameError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxString resetConfirmationError = ''.obs;
  final AuthController _authController = Get.find<AuthController>();
  RxBool passwordIsObscure = true.obs;
  RxBool newPasswordIsObscure = true.obs;

  //Update profil
  Future<bool> updateProfile({required String name}) async {
    loading.value = true;
    if (name.isEmpty) {
      nameError.value = "Veuillez renseigner votre nom";
      loading.value = false;
      return false;
    }

    nameError.value = "";

    try {
      final response = await ApiService.post(ApiEndPoint.updateProfile, {
        'name': name,
      });

      final data = response.data;

      _authController.user.value = User.fromJson(data['data']);

      showSnackBarWidget(
        type: 'success',
        content: 'Profil mis à jour avec succès',
      );

      loading.value = false;

      return true;
    } catch (e) {
      loading.value = false;
      print('Erreur lors de la modification du profil : $e');
      return false;
    }
  }

  //Modification du mot de passe
  Future<bool> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    loading.value = true;

    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      alert('error', 'Veuillez renseigner tous les champs');
      loading.value = false;
      return false;
    }

    if (newPassword != confirmPassword) {
      alert('error', 'Les mots de passe ne correspondent pas');
      resetConfirmationError.value = 'Les mots de passe ne correspondent pas';
      loading.value = false;
      return false;
    }

    resetConfirmationError.value = "";
    passwordError.value = "";

    print('################################################################');
    print('Password : $newPassword');
    print('Confirm : $confirmPassword');
    print('################################################################');

    try {
      final response = await ApiService.post(ApiEndPoint.updatePassword, {
        'oldpassword': currentPassword,
        'newpassword': newPassword,
        'password_confirmation': confirmPassword,
      });

      final data = response.data;
      showSnackBarWidget(
        type: 'success',
        content: 'Mot de passe modifié avec succès',
      );

      loading.value = false;

      return true;
    } catch (e) {
      loading.value = false;
      print('Erreur lors de la modification du mot de passe : $e');
      return false;
    }
  }
}
