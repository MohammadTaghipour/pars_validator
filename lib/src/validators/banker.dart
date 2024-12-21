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
      return _bankByCard[bin];
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

final Map<String, String> _bankByCard = {
  "636795": "مرکزی",
  "603799": "ملی",
  "610433": "ملت",
  "991975": "ملت",
  "628023": "مسکن",
  "603769": "صادرات",
  "627648": "توسعه صادرات",
  "207177": "توسعه صادرات",
  "589210": "سپه",
  "627353": "تجارت",
  "603770": "کشاورزی",
  "639217": "کشاورزی",
  "589463": "رفاه کارگران",
  "636214": "آینده",
  "621986": "سامان",
  "639607": "سرمایه",
  "639346": "سینا",
  "505416": "گردشگری",
  "502938": "دی",
  "502806": "شهر",
  "627961": "صنعت و معدن",
  "505785": "ایران زمین",
  "639347": "پاسارگاد",
  "502229": "پاسارگاد",
  "622106": "پارسیان",
  "639194": "پارسیان",
  "627884": "پارسیان",
  "627412": "اقتصاد نوین",
  "639599": "قوامین",
  "627381": "انصار",
  "627760": "پست بانک ایران",
  "502908": "توسعه تعاون",
  "504172": "رسالت",
  "627488": "کارآفرین",
  "502910": "کارآفرین",
  "639370": "مهر اقتصاد",
  "636949": "حمکت ایرانیان",
  "606373": "موسسه قرض الحسنه مهر ایران",
  "628157": "موسسه اعتباری توسعه",
  "505801": "موسسه اعتباری کوثر",
};
