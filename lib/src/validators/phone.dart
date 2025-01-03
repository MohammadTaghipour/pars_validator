import 'package:flutter/widgets.dart';
import 'package:pars_validator/src/models/models.dart';
import 'package:pars_validator/src/widgets/mobile_operator_icon.dart';

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

  /// Retrieves the mobile operator name for a valid Iranian mobile number.
  ///
  /// ### Example:
  /// ```dart
  /// String? operator = Phone.getMobileOperator('+98 912 345 6789'); // همراه اول
  ///
  /// operator = Phone.getMobileOperator('09361234567'); // ایرانسل
  ///
  /// operator = Phone.getMobileOperator('12345'); // null
  ///```
  /// ### Parameters:
  /// - [mobileNumber]: The mobile number to identify the operator for. The number should be in a valid format.
  ///
  /// ### Returns:
  /// - The name of the mobile operator if the mobile number is valid and matches an operator code.
  /// - `null` if the number is invalid or does not match any operator.
  static String? getMobileOperator(String mobileNumber) {
    if (isMobileNumberValid(mobileNumber)) {
      mobileNumber = mobileNumber.replaceAll(RegExp(r'\s+'), '');
      if (mobileNumber.startsWith('+98')) {
        mobileNumber = '0' + mobileNumber.substring(3);
      } else if (mobileNumber.startsWith('0098')) {
        mobileNumber = '0' + mobileNumber.substring(4);
      }
      for (var operator in _mobileOperators) {
        for (var code in operator.numberCode) {
          if (mobileNumber.startsWith(code)) {
            return operator.operator;
          }
        }
      }
    }
    return null;
  }

  /// Retrieves the mobile operator icon for a valid Iranian mobile number.
  ///
  /// ### Example:
  /// ```dart
  /// Widget? operatorIcon = Phone.getMobileOperatorIcon('+98 912 345 6789'); // Hamrah-Avval icon widget
  ///
  /// operatorIcon = Phone.getMobileOperatorIcon('12345'); // null
  ///```
  /// ### Parameters:
  /// - [mobileNumber]: The mobile number to identify the operator for. The number should be in a valid format.
  ///
  /// ### Returns:
  /// - The icon of the mobile operator as a widget if the mobile number is valid and matches an operator code.
  /// - `null` if the number is invalid or does not match any operator.
  static Widget? getMobileOperatorIcon(String mobileNumber) {
    if (isMobileNumberValid(mobileNumber)) {
      mobileNumber = mobileNumber.replaceAll(RegExp(r'\s+'), '');
      if (mobileNumber.startsWith('+98')) {
        mobileNumber = '0' + mobileNumber.substring(3);
      } else if (mobileNumber.startsWith('0098')) {
        mobileNumber = '0' + mobileNumber.substring(4);
      }
      for (var operator in _mobileOperators) {
        for (var code in operator.numberCode) {
          if (mobileNumber.startsWith(code)) {
            return MobileOperatorIcon(operator: operator);
          }
        }
      }
    }
    return null;
  }
}

final List<MobileOperator> _mobileOperators = [
  MobileOperator(
    operator: 'همراه اول',
    numberCode: [
      '0910',
      '0911',
      '0912',
      '0913',
      '0914',
      '0915',
      '0916',
      '0917',
      '0918',
      '0919',
      '0991',
      '0990',
      '0992',
      '0993',
    ],
    iconPath: 'hamrah_avval.svg',
  ),
  MobileOperator(
    operator: 'ایرانسل',
    numberCode: [
      '0935',
      '0901',
      '0902',
      '0903',
      '0930',
      '0933',
      '0905',
      '0936',
      '0937',
      '0938',
      '0939',
    ],
    iconPath: 'irancell.svg',
  ),
  MobileOperator(
    operator: 'رایتل',
    numberCode: [
      '0920',
      '0921',
      '0922',
    ],
    iconPath: 'rightel.svg',
  ),
  MobileOperator(
    operator: 'اسپادان',
    numberCode: [
      '0931',
    ],
    iconPath: 'spadan.svg',
  ),
  MobileOperator(
    operator: 'تله کیش',
    numberCode: [
      '0934769',
      '0934768',
    ],
    iconPath: 'telekish.svg',
  ),
  MobileOperator(
    operator: 'سامانتل',
    numberCode: [
      '099999',
      '09999',
    ],
    iconPath: 'samantel.svg',
  ),
  MobileOperator(
    operator: 'آپتل',
    numberCode: [
      '09991',
    ],
    iconPath: 'aptel.svg',
  ),
  MobileOperator(
    operator: 'تالیا',
    numberCode: [
      '0932',
    ],
    iconPath: 'taliya.svg',
  ),
  MobileOperator(
    operator: 'لوتوس تل',
    numberCode: [
      '0999',
    ],
    iconPath: 'lotustel.svg',
  ),
];

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
