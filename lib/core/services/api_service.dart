import 'package:depenses/core/controllers/authController.dart';
import 'package:depenses/core/routes/api_end_point.dart';
import 'package:depenses/utils/helper.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
        baseUrl: ApiEndPoint.apiUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3)),
  );

  static void initializeInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        //Ajout du token
        options.headers['Accept'] = 'application/json';
        final token = Get.find<AuthController>().getToken();

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        await handleApiError(e);
        return handler.next(e);
      },
    ));
  }

  static Future<void> handleApiError(DioException e) async {
    try {
      switch (e.response?.statusCode) {
        case 401:
          showSnackBarWidget(
            type: 'error',
            content:
                'Votre session a été interrompue ! Veuillez vous connecter svp.',
          );
          await Get.find<AuthController>().logout();
          break;

        case 422:
          final dataError = e.response?.data['data'];
          if (dataError != null) {
            showErrors(dataError);
          } else {
            showDialogWidget('Erreur de validation',
                'Une erreur est survenue lors de la validation des données');
          }
          break;

        case 406:
          final message =
              e.response?.data['message'] ?? 'Une erreur est survenue';
          showDialogWidget('Oups !', message);
          break;

        default:
          print('######## Status code : ${e.response?.statusCode}');
          showDialogWidget('Erreur',
              'Une erreur inattendue est survenue. Veuillez réessayer.');
          break;
      }
    } catch (error) {
      print('Erreur lors du traitement de l\'erreur: $error');
      showDialogWidget('Erreur', 'Une erreur inattendue est survenue');
    }
  }

  static Future post(String path, dynamic data) async {
    return await _dio.post(path, data: data);
  }

  static Future get(String path, {Map<String, dynamic>? query}) async {
    return await _dio.get(path, queryParameters: query);
  }
}
