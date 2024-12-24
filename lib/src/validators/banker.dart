import 'package:flutter/material.dart';
import 'package:pars_validator/src/models/bank.dart';
import 'package:pars_validator/src/widgets/widgets.dart';

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

  /// Retrieves the bank name associated with the given card number.
  ///
  /// If a match is found, the corresponding
  /// bank name is returned; otherwise, `null` is returned.
  ///
  /// Example:
  /// ```dart
  /// String? bankName = Banker.getBankNameByCardNumber('6274129005473742'); // 'اقتصاد نوین'
  /// ```
  ///
  /// - [cardNumber]: The credit card number to analyze.
  /// Returns the bank name as a `String`, or `null` if the card number is invalid.
  static String? getBankNameByCardNumber(String cardNumber) {
    if (isCardNumberValid(cardNumber)) {
      String bin = cardNumber.substring(0, 6);
      Bank? bank = _banks.firstWhere(
          (element) => element!.cardPrefixes.contains(bin),
          orElse: () => null);
      if (bank != null) {
        return bank.name;
      }
    }
    return null;
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
  static String formatCardNumber(
    String cardNumber, {
    String splitter = ' ',
    int groupSize = 4,
  }) {
    if (!isCardNumberValid(cardNumber)) {
      throw ArgumentError('Card number is not valid.');
    }

    if (groupSize <= 0) {
      throw ArgumentError('Group size must be greater than 0.');
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

  /// Returns a Flutter widget representing the bank's icon based on the card number.
  ///
  /// This method retrieves the icon widget
  /// associated with the bank, based on the card number. The size of the icon
  /// can be customized using the [size] parameter.
  ///
  /// Example:
  /// ```dart
  /// Widget? icon = Banker.getIcon('6274129005473742', size: 32);
  /// ```
  ///
  /// - [size]: The size of the icon, default is 24.
  /// Returns a `Widget` representing the bank's icon if the card number is valid
  /// and the bank is recognized; otherwise, returns `null`.
  static Widget? getIcon(String cardNumber, {double size = 24}) {
    String? bankName = getBankNameByCardNumber(cardNumber);
    if (bankName != null) {
      Bank? bank = _banks.firstWhere((element) => element!.name == bankName,
          orElse: () => null);
      if (bank != null) {
        return BankIcon(
          bank: bank,
          size: size,
        );
      }
    }
    return null;
  }
}

final List<Bank?> _banks = [
  Bank(name: 'مرکزی', cardPrefixes: ['636795'], iconPath: 'markazi.svg'),
  Bank(name: 'ملی', cardPrefixes: ['603799'], iconPath: 'melli.svg'),
  Bank(name: 'ملت', cardPrefixes: ['610433', '991975'], iconPath: 'mellat.svg'),
  Bank(name: 'مسکن', cardPrefixes: ['628023'], iconPath: 'maskan.svg'),
  Bank(name: 'صادرات', cardPrefixes: ['603769'], iconPath: 'saderat.svg'),
  Bank(
      name: 'توسعه صادرات',
      cardPrefixes: ['627648', '207177'],
      iconPath: 'tosee_saderat.svg'),
  Bank(name: 'سپه', cardPrefixes: ['589210'], iconPath: 'sepah.svg'),
  Bank(name: 'تجارت', cardPrefixes: ['627353'], iconPath: 'tejarat.svg'),
  Bank(
      name: 'کشاورزی',
      cardPrefixes: ['603770', '639217'],
      iconPath: 'keshavarzi.svg'),
  Bank(name: 'رفاه کارگران', cardPrefixes: ['589463'], iconPath: 'refah.svg'),
  Bank(name: 'آینده', cardPrefixes: ['636214'], iconPath: 'ayandeh.svg'),
  Bank(name: 'سامان', cardPrefixes: ['621986'], iconPath: 'saman.svg'),
  Bank(name: 'سرمایه', cardPrefixes: ['639607'], iconPath: 'sarmayeh.svg'),
  Bank(name: 'سینا', cardPrefixes: ['639346'], iconPath: 'sina.svg'),
  Bank(name: 'گردشگری', cardPrefixes: ['505416'], iconPath: 'gardeshgari.svg'),
  Bank(name: 'دی', cardPrefixes: ['502938'], iconPath: 'dey.svg'),
  Bank(name: 'شهر', cardPrefixes: ['502806'], iconPath: 'shahr.svg'),
  Bank(
      name: 'صنعت و معدن',
      cardPrefixes: ['627961'],
      iconPath: 'sanat_madan.svg'),
  Bank(
      name: 'ایران زمین', cardPrefixes: ['505785'], iconPath: 'iran_zamin.svg'),
  Bank(
      name: 'پاسارگاد',
      cardPrefixes: ['639347', '502229'],
      iconPath: 'pasargad.svg'),
  Bank(
      name: 'پارسیان',
      cardPrefixes: ['622106', '639194', '627884'],
      iconPath: 'parsian.svg'),
  Bank(
      name: 'اقتصاد نوین',
      cardPrefixes: ['627412'],
      iconPath: 'eghtesad_novin.svg'),
  Bank(name: 'قوامین', cardPrefixes: ['639599'], iconPath: 'ghavamin.svg'),
  Bank(name: 'انصار', cardPrefixes: ['627381'], iconPath: 'ansar.svg'),
  Bank(
      name: 'پست بانک ایران',
      cardPrefixes: ['627760'],
      iconPath: 'postbank.svg'),
  Bank(
      name: 'توسعه تعاون',
      cardPrefixes: ['502908'],
      iconPath: 'tosee_taavon.svg'),
  Bank(name: 'رسالت', cardPrefixes: ['504172'], iconPath: 'resalat.svg'),
  Bank(
      name: 'کارآفرین',
      cardPrefixes: ['627488', '502910'],
      iconPath: 'karafarin.svg'),
  Bank(
      name: 'مهر اقتصاد',
      cardPrefixes: ['639370'],
      iconPath: 'mehr_eghtesad.svg'),
  Bank(name: 'حمکت ایرانیان', cardPrefixes: ['636949'], iconPath: 'hekmat.svg'),
  Bank(
      name: 'موسسه قرض الحسنه مهر ایران',
      cardPrefixes: ['606373'],
      iconPath: 'mehr_iran.svg'),
  Bank(
      name: 'موسسه اعتباری توسعه',
      cardPrefixes: ['628157'],
      iconPath: 'tosee.svg'),
  Bank(
      name: 'موسسه اعتباری کوثر',
      cardPrefixes: ['505801'],
      iconPath: 'kosar.svg'),
];