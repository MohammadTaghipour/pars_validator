/// A utility class for validating and processing phone numbers.
class Phone {
  /// Validates whether a given mobile phone number is in the correct format for Iranian mobile numbers.
  ///
  /// ### Example:
  /// ```dart
  /// bool isValid = Phone.isMobileNumberValid('+98 912 345 6789'); // true
  ///
  /// isValid = Phone.isMobileNumberValid('09123456789'); // true
  ///
  /// isValid = Phone.isMobileNumberValid('12345'); // false
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
  /// bool isValid = Phone.isLandlineNumberValid('+98 21 1234 5678'); // true
  ///
  /// isValid = Phone.isLandlineNumberValid('02112345678'); // true
  ///
  /// isValid = Phone.isLandlineNumberValid('12345'); // false
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

  /// Retrieves the province name associated with a valid Iranian landline number.
  ///
  /// ### Example:
  /// ```dart
  /// String? province = Phone.getLandlineNumberProvince('0211234567890'); // 'تهران'
  ///
  /// province = Phone.getLandlineNumberProvince('09123456789'); // null
  /// ```
  ///
  /// ### Parameters:
  /// - [landLineNumber]: The landline number to retrieve the province for. The number should be in a valid format.
  ///
  /// ### Returns:
  /// - The name of the province if the landline number is valid.
  /// - `null` if the number is invalid or does not match any province.
  static String? getLandlineNumberProvince(String landLineNumber) {
    if (isLandlineNumberValid(landLineNumber)) {
      String codePrefix = landLineNumber.substring(0, 3);
      return _landlineNumberCodes[codePrefix];
    }
    return null;
  }
}

final Map<String, String> _landlineNumberCodes = {
  "041": "آذربایجان شرقی",
  "044": "آذربایجان غربی",
  "045": "اردبیل",
  "031": "اصفهان",
  "084": "ایلام",
  "077": "بوشهر",
  "021": "تهران",
  "038": "چهارمحال و بختیاری",
  "051": "خراسان رضوی",
  "056": "خراسان جنوبی",
  "058": "خراسان شمالی",
  "061": "خوزستان",
  "024": "زنجان",
  "023": "سمنان",
  "054": "سیستان و بلوچستان",
  "071": "فارس",
  "026": "البرز",
  "025": "قم",
  "028": "قزوین",
  "087": "کردستان",
  "034": "کرمان",
  "083": "کرمانشاه",
  "074": "کهگیلویه و بویراحمد",
  "017": "گلستان",
  "013": "گیلان",
  "066": "لرستان",
  "086": "مرکزی",
  "076": "هرمزگان",
  "081": "همدان",
  "035": "یزد"
};
