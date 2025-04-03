abstract class ApiEndPoint {
  static const String apiBaseUrl = 'http://192.168.1.35:8000';
  static const String apiUrl = '$apiBaseUrl/api/v1';
  static const String login = '/login';
  static const String register = '/register';
  static const String verifyEmail = '/verify/email';
  static const String verifyCode = '/verify/code';
  static const String resetPassword = '/resetPassword';
  static const String loginWithSocial = '/auth/socialite';
  static const String updateProfile = '/profile/update';
  static const String updatePassword = '/profile/update/password';
  static const String historique = '/historiques';
  static const String deleteHistorique = '/historiques/delete';
}
