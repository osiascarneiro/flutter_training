import 'package:intl/intl.dart';

class Util {
  static String appId = "09fe393c97d54d16b58dc25e27e30e18";

  static String getFormattedDate(DateTime dateTime) {
    return new DateFormat("EEE, MMM d, y").format(dateTime);
  }
}