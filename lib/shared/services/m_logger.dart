import 'package:logger/logger.dart';

class LoggerService {
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
}
