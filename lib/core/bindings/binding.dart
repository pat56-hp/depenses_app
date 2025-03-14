import 'package:depenses/core/controllers/authController.dart';
import 'package:depenses/screens/auth/controllers/forgot_controller.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }
}

class ForgotBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ForgotController>(ForgotController());
  }
}
