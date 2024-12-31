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
    GetPage(name: '/login', page: () => const Login()),
    GetPage(name: '/register', page: () => const Register()),
    GetPage(name: '/forgot_password', page: () => const ForgotPassword()),
    GetPage(name: '/reset_password', page: () => const ResetPassword()),
    GetPage(name: '/home', page: () => const Home())
  ];
}
