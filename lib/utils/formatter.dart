class Formatter {
  static String formatThousands(String input) {
    final numericalOnly = input.replaceAll(RegExp('[^0-9]'), '');
    return numericalOnly.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }

  static String formatPercentage(String input) {
    final numericalOnly = input.replaceAll(RegExp('[^0-9]'), '');
    return '$numericalOnly%';
  }

  static String formatVND(String input) {
    final numericalOnly = input.replaceAll(RegExp('[^0-9]'), '');
    final formattedNumber = numericalOnly.replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
    return '$formattedNumber VND';
  }
}
