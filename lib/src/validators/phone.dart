/// A utility class for validating and processing phone numbers.
class Phone {
  /// Validates whether a given mobile phone number is in the correct format for Iranian mobile numbers.
  ///
  /// ### Example:
  /// ```dart
  /// bool isValid = Phone.isMobileNumberValid('+98 912 345 6789');
  /// print(isValid); // true
  ///
  /// isValid = Phone.isMobileNumberValid('09123456789');
  /// print(isValid); // true
  ///
  /// isValid = Phone.isMobileNumberValid('12345');
  /// print(isValid); // false
  /// ```
  ///
  /// ### Parameters:
  /// - [mobileNumber]: The mobile number to validate. This can be in various formats, including with or without international prefixes.
  ///
  /// ### Returns:
  /// - `true` if the mobile number is valid and matches the Iranian mobile number format.
  /// - `false` otherwise.
  static bool isMobileNumberValid(String mobileNumber) {
    mobileNumber = mobileNumber.replaceAll(RegExp(r'\s+'), '');
    if (mobileNumber.startsWith('+98')) {
      mobileNumber = '0' + mobileNumber.substring(3);
    } else if (mobileNumber.startsWith('0098')) {
      mobileNumber = '0' + mobileNumber.substring(4);
    }
    return RegExp(r'^09\d{9}$').hasMatch(mobileNumber);
  }

  /// Validates whether a given phone number is in the correct format for Iranian landline numbers.
  ///
  /// ### Example:
  /// ```dart
  /// bool isValid = Phone.isLandlineNumberValid('+98 21 1234 5678');
  /// print(isValid); // true
  ///
  /// isValid = Phone.isLandlineNumberValid('02112345678');
  /// print(isValid); // true
  ///
  /// isValid = Phone.isLandlineNumberValid('12345');
  /// print(isValid); // false
  /// ```
  ///
  /// ### Parameters:
  /// - [phoneNumber]: The phone number to validate. This can be in various formats, including with or without international prefixes.
  ///
  /// ### Returns:
  /// - `true` if the phone number is valid and matches the Iranian landline number format.
  /// - `false` otherwise.
  static bool isLandlineNumberValid(String phoneNumber) {
    phoneNumber = phoneNumber.replaceAll(RegExp(r'\s+'), '');
    if (phoneNumber.startsWith('+98')) {
      phoneNumber = '0' + phoneNumber.substring(3);
    } else if (phoneNumber.startsWith('0098')) {
      phoneNumber = '0' + phoneNumber.substring(4);
    }
    return RegExp(r'^0\d{10}$').hasMatch(phoneNumber);
  }
}
