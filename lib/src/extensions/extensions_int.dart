import '../validators/validators.dart';

extension IntValidation on int {
  /// Converts an integer number between 0 to 999,999,999,999 into its corresponding Persian words representation.
  ///
  /// ### Example:
  /// ```dart
  /// String result = 123456789.numberToLetters();
  /// print(result); // 'یک صد و بیست و سه میلیون چهار صد و پنجاه و شش هزار هفت صد و هشتاد و نه'
  ///
  /// result = 1000.numberToLetters();
  /// print(result); // 'یک هزار'
  /// ```
  ///
  /// ### Returns:
  /// - The Persian word representation of the number.
  String numberToLetters() {
    return General.numberToLetters(this);
  }

  /// Converts a number representing an amount in Rials into a human-readable Persian format.
  ///
  ///
  /// ### Example:
  /// ```dart
  /// String price = 1234567890.numberToPrice(); // خروجی: ۱۲ میلیون و ۳۴۵ هزار و ۶۷۸ تومان و ۹ ریال
  /// ```
  ///
  /// ### Returns:
  /// - A formatted string representing the amount in Tomans and Rials, converted to Persian characters.
  String numberToPrice() {
    return General.numberToPrice(this);
  }
}
