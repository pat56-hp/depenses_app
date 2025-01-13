import 'package:depenses/core/bindings/binding.dart';
import 'package:depenses/screens/auth/verify_code.dart';
import 'package:depenses/screens/home/home.dart';
import 'package:get/get.dart';
import 'package:depenses/screens/auth/forgot_password.dart';
import 'package:depenses/screens/auth/login.dart';
import 'package:depenses/screens/auth/register.dart';
import 'package:depenses/screens/auth/reset_password.dart';
import 'package:depenses/screens/onboading/onboading.dart';
import 'package:get/route_manager.dart';

class Routes {
  static List<GetPage<dynamic>> appRoutes = [
    GetPage(name: '/onboading', page: () => const Onboading()),
    GetPage(
      name: '/login',
      page: () => const Login(),
      binding: AuthBinding(),
    ),
    GetPage(
        name: '/register',
        page: () => const Register(),
        binding: AuthBinding()),
    GetPage(
        name: '/verify_code',
        page: () => const VerifyCode(),
        binding: ForgotBinding()),
    GetPage(
        name: '/forgot_password',
        page: () => const ForgotPassword(),
        binding: ForgotBinding()),
    GetPage(
        name: '/reset_password',
        page: () => const ResetPassword(),
        binding: AuthBinding()),
    GetPage(name: '/home', page: () => const Home())
  ];
}
