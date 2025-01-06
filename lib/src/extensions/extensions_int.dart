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
}
