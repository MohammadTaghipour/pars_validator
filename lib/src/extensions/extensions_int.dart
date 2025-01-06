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

  /// Splits a given int into groups of a specified size, separated by a custom splitter.
  ///
  ///
  /// ### Example:
  /// ```dart
  /// String result = 123456789.separate(splitter: ',', groupSize: 3); // "123,456,789"
  /// ```
  ///
  /// ### Parameters:
  /// - [splitter]: The string used to join the separated groups. Defaults to `','`.
  /// - [groupSize]: The number of characters in each group. Defaults to `3`.
  ///
  /// ### Returns:
  /// - A formatted string where the input is split into groups of size `groupSize`
  ///   and joined by the `splitter`.
  ///
  /// ### Throws:
  /// - `ArgumentError` if the [groupSize] is less than or equal to 0.
  ///
  /// ### Notes:
  /// - The method does not modify the input string directly but returns the formatted result.
  /// - If the input string length is not a multiple of `groupSize`, the last group will contain
  ///   the remaining characters.
  String separate({
    String splitter = ',',
    int groupSize = 3,
  }) {
    return General.separate(this.toString(),
        splitter: splitter, groupSize: groupSize);
  }
}
