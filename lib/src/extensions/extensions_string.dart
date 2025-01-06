import 'package:flutter/cupertino.dart';
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

  /// Retrieves the bank name associated with the given card number.
  ///
  /// If a match is found, the corresponding
  /// bank name is returned; otherwise, `null` is returned.
  ///
  /// Example:
  /// ```dart
  /// String? bankName = '6274129005473742'.getBankNameByCardNumber(); // 'اقتصاد نوین'
  /// ```
  ///
  /// Returns the bank name as a `String`, or `null` if the card number is invalid.
  String? getBankNameByCardNumber() {
    return Banker.getBankNameByCardNumber(this);
  }

  /// Returns a Flutter widget representing the bank's icon based on the card number.
  ///
  /// This method retrieves the icon widget
  /// associated with the bank, based on the card number. The size of the icon
  /// can be customized using the [size] parameter.
  ///
  /// Example:
  /// ```dart
  /// Widget? icon = '6274129005473742'.getIconByCardNumber(size: 32);
  /// ```
  ///
  /// - [size]: The size of the icon, default is 24.
  /// Returns a `Widget` representing the bank's icon if the card number is valid
  /// and the bank is recognized; otherwise, returns `null`.
  Widget? getIconByCardNumber({double size = 24}) {
    return Banker.getIcon(this, size: size);
  }

  /// Validates whether a given mobile phone number is in the correct format for Iranian mobile numbers.
  ///
  /// ### Example:
  /// ```dart
  /// bool isValid = '+98 912 345 6789'.isMobileNumberValid(); // true
  ///
  /// isValid = '09123456789'.isMobileNumberValid(); // true
  ///
  /// isValid = '12345'.isMobileNumberValid(); // false
  /// ```
  ///
  /// ### Returns:
  /// - `true` if the phone number is valid and matches the Iranian mobile number format.
  /// - `false` otherwise.
  bool isMobileNumberValid() {
    return Phone.isMobileNumberValid(this);
  }

  /// Validates whether a given phone number is in the correct format for Iranian landline numbers.
  ///
  /// ### Example:
  /// ```dart
  /// bool isValid = '+98 21 1234 5678'.isLandlineNumberValid(); // true
  ///
  /// isValid = '02112345678'.isLandlineNumberValid(); // true
  ///
  /// isValid = '12345'.isLandlineNumberValid(); // false
  /// ```
  ///
  /// ### Returns:
  /// - `true` if the phone number is valid and matches the Iranian landline number format.
  /// - `false` otherwise.
  bool isLandlineNumberValid() {
    return Phone.isLandlineNumberValid(this);
  }

  /// Retrieves the province name associated with a valid Iranian landline number.
  ///
  /// ### Example:
  /// ```dart
  /// String? province = '02112345678'.getLandlineNumberProvince(); // 'تهران'
  ///
  /// province = '09123456789'.getLandlineNumberProvince(); // null
  /// ```
  ///
  /// ### Parameters:
  /// - [landLineNumber]: The landline number to retrieve the province for. The number should be in a valid format.
  ///
  /// ### Returns:
  /// - The name of the province if the landline number is valid.
  /// - `null` if the number is invalid or does not match any province.
  String? getLandlineNumberProvince() {
    return Phone.getLandlineNumberProvince(this);
  }

  /// Retrieves the mobile operator name for a valid Iranian mobile number.
  ///
  /// ### Example:
  /// ```dart
  /// String? operator = '+98 912 345 6789'.getMobileOperator(); // همراه اول
  ///
  /// operator = '09361234567'.getMobileOperator(); // ایرانسل
  ///
  /// operator = '12345'.getMobileOperator(); // null
  ///```
  ///
  /// ### Returns:
  /// - The name of the mobile operator if the mobile number is valid and matches an operator code.
  /// - `null` if the number is invalid or does not match any operator.
  String? getMobileNumberOperator() {
    return Phone.getMobileOperator(this);
  }

  /// Retrieves the mobile operator icon for a valid Iranian mobile number.
  ///
  /// ### Example:
  /// ```dart
  /// Widget? operatorIcon = '+98 912 345 6789'.getMobileOperatorIcon(); // Hamrah-Avval icon widget
  ///
  /// operatorIcon = '12345'.getMobileOperatorIcon(); // null
  ///```
  ///
  /// - [size]: The size of the icon, default is 24.
  /// ### Returns:
  /// - The icon of the mobile operator as a widget if the mobile number is valid and matches an operator code.
  /// - `null` if the number is invalid or does not match any operator.
  Widget? getMobileNumberOperatorIcon({double size = 24}) {
    return Phone.getMobileOperatorIcon(this, size: size);
  }

  /// Validates whether a given email address conforms to a standard email format.
  ///
  /// ### Example:
  /// ```dart
  /// bool isValid = 'example@domain.com'.isEmailValid(); // true
  ///
  /// isValid = 'invalid-email'.isEmailValid(); // false
  /// ```
  ///
  /// ### Returns:
  /// - `true` if the email address is valid and matches the standard email format.
  /// - `false` otherwise.
  bool isEmailValid() {
    return Phone.isEmailValid(this);
  }

  /// Validates whether a given text contains only Persian letters and spaces.
  ///
  /// ### Example:
  /// ```dart
  /// bool isValid = 'سلام دنیا'.containsOnlyPersianLetters(); // true
  ///
  /// isValid = 'سلام 123'.containsOnlyPersianLetters(); // false
  /// ```
  ///
  /// ### Returns:
  /// - `true` if the text contains only Persian letters and spaces.
  /// - `false` otherwise.
  bool containsOnlyPersianLetters() {
    return General.onlyPersianLetters(this);
  }

  /// Validates the word count of a given text.
  ///
  /// Ensures the word count falls within the specified range.
  ///
  /// ### Example:
  /// ```dart
  /// bool isValid = 'سلام دنیا'.validateWordCount(1, 3); // true
  ///
  /// isValid = 'یک دو سه چهار پنج'.validateWordCount(2, 4); // false
  /// ```
  ///
  /// ### Parameters:
  /// - [minWords]: The minimum word count.
  /// - [maxWords]: The maximum word count.
  ///
  /// ### Returns:
  /// - `true` if the word count is within the specified range.
  /// - `false` otherwise.
  bool validateWordCount(int minWords, int maxWords) {
    return General.validateWordCount(this, minWords, maxWords);
  }

  /// Counts the number of words in a given text.
  ///
  /// ### Example:
  /// ```dart
  /// int wordCount = 'Hello World!'.length(); // 2
  /// ```
  ///
  /// ### Returns:
  /// - The number of words in the text.
  int length() {
    return General.getWordCount(this);
  }

  /// Converts a text to Persian format, replacing Arabic characters and English digits.
  ///
  /// ### Example:
  /// ```dart
  /// String converted = '123 كلمه'.toPersian(); // '۱۲۳ کلمه'
  /// ```
  ///
  /// ### Returns:
  /// - The converted text with Arabic characters and English digits replaced by their Persian equivalents.
  String toPersian() {
    return General.toPersian(this);
  }

  /// Converts Persian and Arabic digits in a text to English digits.
  ///
  /// ### Example:
  /// ```dart
  /// String converted = '۱۲۳۴'.withEnglishNumbers(); // '1234'
  /// ```
  ///
  /// ### Returns:
  /// - The converted text with Persian and Arabic digits replaced by English digits.
  String withEnglishNumbers() {
    return General.toEnglishNumbers(this);
  }

  /// Converts an integer number between 0 to 999,999,999,999 into its corresponding Persian words representation.
  ///
  /// ### Example:
  /// ```dart
  /// String result = '123456789'.numberToLetters();
  /// print(result); // 'یک صد و بیست و سه میلیون چهار صد و پنجاه و شش هزار هفت صد و هشتاد و نه'
  ///
  /// result = '1000'.numberToLetters();
  /// print(result); // 'یک هزار'
  /// ```
  ///
  /// ### Returns:
  /// - The Persian word representation of the number.
  String numberToLetters() {
    return General.numberToLetters(int.parse(this.trim()));
  }

  /// Converts a number representing an amount in Rials into a human-readable Persian format.
  ///
  ///
  /// ### Example:
  /// ```dart
  /// String price = '1234567890'.numberToPrice(); // خروجی: ۱۲ میلیون و ۳۴۵ هزار و ۶۷۸ تومان و ۹ ریال
  /// ```
  ///
  /// ### Returns:
  /// - A formatted string representing the amount in Tomans and Rials, converted to Persian characters.
  String numberToPrice() {
    return General.numberToPrice(int.parse(this.trim()));
  }

  /// Splits a given string into groups of a specified size, separated by a custom splitter.
  ///
  ///
  /// ### Example:
  /// ```dart
  /// String result = "123456789".separate(splitter: ',', groupSize: 3); // "123,456,789"
  ///
  /// result = "abcdef".separate(splitter: '-', groupSize: 2); // "ab-cd-ef"
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
    return General.separate(this, splitter: splitter, groupSize: groupSize);
  }
}
