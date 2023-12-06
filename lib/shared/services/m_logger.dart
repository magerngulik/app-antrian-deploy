import 'package:logger/logger.dart';

class Ql {
  static final Logger _logger = Logger();

  static void logI(dynamic message) {
    _logger.i(message);
  }

  static void logE(dynamic message, dynamic error) {
    _logger.e('$message: $error');
  }

  static void logW(dynamic message) {
    _logger.w(message);
  }

  static void logF(dynamic message) {
    _logger.f(message);
  }

  static void logD(dynamic message) {
    _logger.d(message);
  }

  static void logT(dynamic message) {
    _logger.t(message);
  }

  static void logWtf(dynamic message) {
    // ignore: deprecated_member_use
    _logger.wtf(message);
  }

  static void logFatal(dynamic message) {
    _logger.log(Level.fatal, message);
  }
}
