abstract class ApiEndPoint {
  static const String apiBaseUrl = 'http://192.168.1.21:8000';
  static const String apiUrl = apiBaseUrl + '/api/v1';
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyEmail = '/verify/email';
  static const String verifyCode = '/verify/code';
  static const String resetPassword = '/resetPassword';
  static const String updateProfile = '/profile/update';
}
