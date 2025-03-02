import 'package:intl/intl.dart';

class DateFormatter {
  static String formatMatchDate(DateTime date) {
    return DateFormat('EEE, MMM d • HH:mm').format(date);
  }

  static String formatTimeElapsed(int minutes) {
    return '$minutes\'';
  }

  static String formatNotificationTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }
}