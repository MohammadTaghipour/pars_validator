/// A utility class for validating and formatting banking-related information.
///
/// The `Banker` class provides methods to validate credit card numbers,
/// format them for readability, and validate IBAN (International Bank Account Number).
class Banker {
  /// Validates a 16-digit credit card number using the Luhn algorithm.
  ///
  /// Returns `true` if the card number is valid, otherwise `false`.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = Banker.isCardNumberValid('1234567812345670'); // true or false
  /// ```
  ///
  /// - [cardNumber]: The credit card number to validate.
  static bool isCardNumberValid(String cardNumber) {
    if (cardNumber.length != 16 || !RegExp(r'^\d{16}$').hasMatch(cardNumber)) {
      return false;
    }
    int sum = 0;
    for (int i = 0; i < cardNumber.length; i++) {
      int digit = int.parse(cardNumber[i]);
      int result;
      if ((i + 1) % 2 == 0) {
        result = digit * 1;
      } else {
        if ((digit * 2) > 9) {
          result = (digit * 2) - 9;
        } else {
          result = digit * 2;
        }
      }
      sum += result;
    }
    return sum % 10 == 0;
  }

  /// Formats a valid credit card number into readable groups.
  ///
  /// Divides the card number into groups of a specified size, separated by
  /// a custom splitter string. Throws an [ArgumentError] if the card number
  /// is invalid or the group size is not greater than 0.
  ///
  /// Example:
  /// ```dart
  /// String formatted = Banker.formatCardNumber('1234567812345670'); // '1234 5678 1234 5670'
  /// ```
  ///
  /// - [cardNumber]: The credit card number to format.
  /// - [splitter]: The string used to separate groups (default is a space `' '`).
  /// - [groupSize]: The number of digits in each group (default is 4).
  static String formatCardNumber(String cardNumber, {
    String splitter = ' ',
    int groupSize = 4,
  }) {
    if (!isCardNumberValid(cardNumber)) {
      throw ArgumentError("Card number is not valid.");
    }

    if (groupSize <= 0) {
      throw ArgumentError("Group size must be greater than 0.");
    }

    List<String> parts = [];
    for (int i = 0; i < cardNumber.length; i += groupSize) {
      parts.add(cardNumber.substring(
          i,
          (i + groupSize > cardNumber.length)
              ? cardNumber.length
              : i + groupSize));
    }

    return parts.join(splitter);
  }

  /// Validates an IBAN (International Bank Account Number).
  ///
  /// Returns `true` if the IBAN is valid, otherwise `false`.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = Banker.isIBANValid('IR820540102680020817909007');
  /// ```
  ///
  /// - [iban]: The IBAN string to validate.
  static bool isIBANValid(String iban) {
    if (iban.length != 26 || !RegExp(r'^[A-Z0-9]+$').hasMatch(iban)) {
      return false;
    }
    String reformattedIban = iban.substring(4) + iban.substring(0, 4);
    String numericIban = reformattedIban.split('').map((char) {
      if (RegExp(r'[A-Z]').hasMatch(char)) {
        return (char.codeUnitAt(0) - 55).toString();
      } else {
        return char;
      }
    }).join();
    BigInt ibanValue = BigInt.parse(numericIban);
    return ibanValue % BigInt.from(97) == BigInt.one;
  }
}
