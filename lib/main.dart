import 'package:depenses/core/routes/routes.dart';
import 'package:depenses/core/services/api_service.dart';
import 'package:depenses/screens/onboading/onboading.dart';
import 'package:depenses/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  ApiService.initializeInterceptors();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dépenses',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const Onboading(),
      initialRoute: '/onboading',
      getPages: Routes.appRoutes,
    );
  }
}
