import 'package:intl/intl.dart';

class TimeUtils {
  static String getLocalStrFromDate(DateTime dateTime) =>
      DateFormat.yMd(Intl.defaultLocale).format(dateTime);
}
