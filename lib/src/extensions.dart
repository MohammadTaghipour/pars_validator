import 'package:pars_validator/pars_validator.dart';

/// Extension methods for adding validation and formatting utilities to `String`.
///
/// This extension leverages the functionality provided by `pars_validator`
/// to validate and format various types of data, including national IDs,
/// credit card numbers, and IBANs.
extension StringValidation on String {
  // NationalID ----------

  /// Validates an Iranian National ID.
  ///
  /// Checks the given [nationalCode] for the correct format and
  /// verifies the checksum to determine if it is valid.
  ///
  /// - [nationalCode]: The National ID to validate (a 10-digit string).
  ///
  /// Returns `true` if the National ID is valid; otherwise, returns `false`.
  ///
  /// ```dart
  /// bool isValid = '1234567891'.isNationalIDValid();
  /// ```
  bool isNationalIDValid() {
    return NationalID.isNationalIDValid(this);
  }

  /// Generates a random valid Iranian National ID.
  ///
  /// This method creates a 10-digit valid National ID by generating
  /// 9 random digits and calculating the checksum for validity.
  ///
  /// Returns a valid National ID as a [String].
  ///
  /// ```dart
  /// String randomID = ''.generateRandomID();
  /// ```
  String generateRandomNationalID() {
    return NationalID.generateRandomID();
  }

  /// Retrieves the issuance location of a National ID.
  ///
  /// Based on the first three digits of the [nationalCode], this method
  /// determines the city or province where the National ID was issued.
  ///
  /// - [nationalCode]: The National ID to analyze (a 10-digit string).
  ///
  /// Returns the name of the issuance location as a [String], or `null`
  /// if the location cannot be determined.
  ///
  /// ```dart
  /// String? issuance = '1234567891'.getIssuanceOfNationalID();
  /// ```
  String? getIssuanceOfNationalID() {
    return NationalID.getIssuance(this);
  }

  // Banker ----------

  /// Validates a 16-digit credit card number using the Luhn algorithm.
  ///
  /// Returns `true` if the card number is valid, otherwise `false`.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = '1234567812345670'.isCardNumberValid(); // true or false
  /// ```
  ///
  /// - [cardNumber]: The credit card number to validate.
  bool isCardNumberValid() {
    return Banker.isCardNumberValid(this);
  }

  /// Formats a valid credit card number into readable groups.
  ///
  /// Divides the card number into groups of a specified size, separated by
  /// a custom splitter string. Throws an [ArgumentError] if the card number
  /// is invalid or the group size is not greater than 0.
  ///
  /// Example:
  /// ```dart
  /// String formatted = '1234567812345670'.formatCardNumber(); // '1234 5678 1234 5670'
  /// ```
  ///
  /// - [cardNumber]: The credit card number to format.
  /// - [splitter]: The string used to separate groups (default is a space `' '`).
  /// - [groupSize]: The number of digits in each group (default is 4).
  String formatCardNumber({
    String splitter = ' ',
    int groupSize = 4,
  }) {
    return Banker.formatCardNumber(this,
        groupSize: groupSize, splitter: splitter);
  }

  /// Validates an IBAN (International Bank Account Number).
  ///
  /// Returns `true` if the IBAN is valid, otherwise `false`.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = 'IR820540102680020817909007'.isIBANValid();
  /// ```
  ///
  /// - [iban]: The IBAN string to validate.
  bool isIBANValid() {
    return Banker.isIBANValid(this);
  }
}
