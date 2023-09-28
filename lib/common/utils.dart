class CommonUtils {
  static String convertDateDDMMYYYY(DateTime dateTime) {
    return '${dateTime.day}-${dateTime.month}-${dateTime.year}';
  }
}
