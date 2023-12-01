import 'package:logger/logger.dart';

class Ql {
  static final Logger _logger = Logger();

  static void logInfo(dynamic message) {
    _logger.i(message);
  }

  static void logError(dynamic message, dynamic error) {
    _logger.e('$message: $error');
  }

  static void logWarning(dynamic message) {
    _logger.w(message);
  }

  static void logF(dynamic message) {
    _logger.f(message);
  }

  static void logD(dynamic message) {
    _logger.d(message);
  }
}
