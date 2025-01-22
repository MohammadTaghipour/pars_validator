import 'package:pars_validator/src/extensions/extensions_string.dart';

/// A utility class for text-related operations with a focus on Persian language support.
class General {
  /// Validates whether a given text contains only Persian letters and spaces.
  ///
  /// ### Example:
  /// ```dart
  /// bool isValid = General.onlyPersianLetters('سلام دنیا'); // true
  ///
  /// isValid = General.onlyPersianLetters('سلام 123'); // false
  /// ```
  ///
  /// ### Parameters:
  /// - [text]: The input text to validate.
  ///
  /// ### Returns:
  /// - `true` if the text contains only Persian letters and spaces.
  /// - `false` otherwise.
  static bool onlyPersianLetters(String text) {
    final persianRegex = RegExp(r'^[\u0600-\u06FF\s]+$');
    return persianRegex.hasMatch(text);
  }

  /// Validates the word count of a given text.
  ///
  /// Ensures the word count falls within the specified range.
  ///
  /// ### Example:
  /// ```dart
  /// bool isValid = General.validateWordCount('سلام دنیا', 1, 3); // true
  ///
  /// isValid = General.validateWordCount('یک دو سه چهار پنج', 2, 4); // false
  /// ```
  ///
  /// ### Parameters:
  /// - [text]: The input text to validate.
  /// - [minWords]: The minimum word count.
  /// - [maxWords]: The maximum word count.
  ///
  /// ### Returns:
  /// - `true` if the word count is within the specified range.
  /// - `false` otherwise.
  static bool validateWordCount(String text, int minWords, int maxWords) {
    int count = getWordCount(text);
    return count >= minWords && count <= maxWords;
  }

  /// Counts the number of words in a given text.
  ///
  /// ### Example:
  /// ```dart
  /// int wordCount = General.getWordCount('Hello World!'); // 2
  /// ```
  ///
  /// ### Parameters:
  /// - [text]: The input text to count words.
  ///
  /// ### Returns:
  /// - The number of words in the text.
  static int getWordCount(String text) {
    return text
        .trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList()
        .length;
  }

  /// Converts Arabic characters in a text to their Persian equivalents.
  ///
  /// ### Example:
  /// ```dart
  /// String converted = General.arabicToPersian('اراك'); // اراک
  /// ```
  ///
  /// ### Parameters:
  /// - [text]: The input text to convert.
  ///
  /// ### Returns:
  /// - The converted text with Arabic characters replaced by Persian equivalents.
  static String arabicToPersian(String text) {
    const arabicToPersianMap = {
      'ي': 'ی',
      'ك': 'ک',
      '٠': '۰',
      '١': '۱',
      '٢': '۲',
      '٣': '۳',
      '٤': '۴',
      '٥': '۵',
      '٦': '۶',
      '٧': '۷',
      '٨': '۸',
      '٩': '۹',
    };
    return text
        .split('')
        .map((char) => arabicToPersianMap[char] ?? char)
        .join('');
  }

  /// Converts English digits in a text to Persian digits.
  ///
  /// ### Example:
  /// ```dart
  /// String converted = General.englishToPersianNumbers('123'); // '۱۲۳'
  /// ```
  ///
  /// ### Parameters:
  /// - [text]: The input text to convert.
  ///
  /// ### Returns:
  /// - The converted text with English digits replaced by Persian digits.
  static String englishToPersianNumbers(String text) {
    const englishToPersianNumbers = {
      '0': '۰',
      '1': '۱',
      '2': '۲',
      '3': '۳',
      '4': '۴',
      '5': '۵',
      '6': '۶',
      '7': '۷',
      '8': '۸',
      '9': '۹',
    };
    return text
        .split('')
        .map((char) => englishToPersianNumbers[char] ?? char)
        .join('');
  }

  /// Converts a text to Persian format, replacing Arabic characters and English digits.
  ///
  /// ### Example:
  /// ```dart
  /// String converted = General.toPersian('123 كلمه'); // '۱۲۳ کلمه'
  /// ```
  ///
  /// ### Parameters:
  /// - [text]: The input text to convert.
  ///
  /// ### Returns:
  /// - The converted text with Arabic characters and English digits replaced by their Persian equivalents.
  static String toPersian(String text) {
    return arabicToPersian(englishToPersianNumbers(text));
  }

  /// Converts Persian and Arabic digits in a text to English digits.
  ///
  /// ### Example:
  /// ```dart
  /// String converted = General.toEnglishNumbers('۱۲۳۴'); // '1234'
  /// ```
  ///
  /// ### Parameters:
  /// - [text]: The input text to convert.
  ///
  /// ### Returns:
  /// - The converted text with Persian and Arabic digits replaced by English digits.
  static String toEnglishNumbers(String text) {
    const arabicToPersianMap = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '۴': '4',
      '٥': '5',
      '۵': '5',
      '٦': '6',
      '۶': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };
    return text
        .split('')
        .map((char) => arabicToPersianMap[char] ?? char)
        .join('');
  }

  static String _convertThreeDigits(int number) {
    if (number == 0) return "";

    int hundreds = number ~/ 100;
    int remainder = number % 100;
    int tens = remainder ~/ 10;
    int ones = remainder % 10;

    String result = "";

    if (hundreds > 0) {
      result += _hundreds[hundreds];
    }

    if (remainder >= 10 && remainder <= 19) {
      if (result.isNotEmpty) result += " و ";
      result += _teens[remainder - 10];
    } else {
      if (tens > 0) {
        if (result.isNotEmpty) result += " و ";
        result += _tens[tens];
      }

      if (ones > 0) {
        if (result.isNotEmpty) result += " و ";
        result += _ones[ones];
      }
    }

    return result;
  }

  /// Converts an integer number between 0 to 999,999,999,999 into its corresponding Persian words representation.
  ///
  /// ### Example:
  /// ```dart
  /// String result = General.numberToLetters(123456789);
  /// print(result); // 'یک صد و بیست و سه میلیون چهار صد و پنجاه و شش هزار هفت صد و هشتاد و نه'
  ///
  /// result = General.numberToLetters(1000);
  /// print(result); // 'یک هزار'
  /// ```
  ///
  /// ### Parameters:
  /// - [number]: The integer number to convert into words.
  ///
  /// ### Returns:
  /// - The Persian word representation of the number.
  static String numberToLetters(int number) {
    if (number == 0) return "صفر";

    List<String> units = ["", "هزار", "میلیون", "میلیارد"];
    int unitIndex = 0;
    String result = "";

    while (number > 0) {
      int chunk = number % 1000;
      number ~/= 1000;

      if (chunk > 0) {
        String chunkText = _convertThreeDigits(chunk);
        if (unitIndex > 0) {
          chunkText += " " + units[unitIndex];
        }

        if (result.isNotEmpty) {
          result = chunkText + " و " + result;
        } else {
          result = chunkText;
        }
      }

      unitIndex++;
    }
    return result;
  }

  /// Converts a number representing an amount in Rials into a human-readable Persian format.
  ///
  ///
  /// ### Example:
  /// ```dart
  /// String price = General.numberToPrice(1234567890); خروجی: ۱۲ میلیون و ۳۴۵ هزار و ۶۷۸ تومان و ۹ ریال
  /// ```
  ///
  /// ### Parameters:
  /// - [number]: A string representing a numeric value in Rials.
  ///
  /// ### Returns:
  /// - A formatted string representing the amount in Tomans and Rials, converted to Persian characters.
  ///
  /// ### Notes:
  /// - The method assumes the input string is a valid numeric value in Rials.
  /// - Uses `.toPersian()` to convert the output to Persian numerals.
  static String numberToPrice(int numbers) {
    int tomans = numbers ~/ 10;
    int remainingRial = numbers % 10;

    final billions = tomans ~/ 1000000000;
    final millions = (tomans % 1000000000) ~/ 1000000;
    final thousands = (tomans % 1000000) ~/ 1000;
    final units = tomans % 1000;

    List<String> parts = [];
    if (billions > 0) parts.add('$billions میلیارد');
    if (millions > 0) parts.add('$millions میلیون');
    if (thousands > 0) parts.add('$thousands هزار');
    if (units > 0) parts.add('$units');
    if (remainingRial > 0) {
      return '${parts.join(" و ")} تومان و $remainingRial ریال'.toPersian();
    } else {
      return '${parts.join(" و ")} تومان'.toPersian();
    }
  }

  /// Splits a given string into groups of a specified size, separated by a custom splitter.
  ///
  ///
  /// ### Example:
  /// ```dart
  /// String result = General.separate("123456789", splitter: ',', groupSize: 3); // "123,456,789"
  ///
  /// result = General.separate("abcdef", splitter: '-', groupSize: 2); // "ab-cd-ef"
  /// ```
  ///
  /// ### Parameters:
  /// - [text]: The input string to be split.
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
  static String separate(
    String text, {
    String splitter = ',',
    int groupSize = 3,
  }) {
    if (groupSize <= 0) {
      throw ArgumentError('Group size must be greater than 0.');
    }
    List<String> parts = [];
    for (int i = 0; i < text.length; i += groupSize) {
      parts.add(text.substring(
          i, (i + groupSize > text.length) ? text.length : i + groupSize));
    }
    return parts.join(splitter);
  }

  /// Validates whether the given OTP (One-Time Password) is valid.
  ///
  ///
  /// ### Example:
  /// ```dart
  /// bool isValid = General.isOTPValid("123456", 6); // true
  /// ```
  ///
  /// ### Parameters:
  /// - [text]: The input OTP string to validate.
  /// - [length]: The expected length of the OTP.
  ///
  /// ### Returns:
  /// - `true` if the OTP is valid (non-empty, correct length, numeric).
  /// - `false` otherwise.
  static bool isOTPValid(String text, int length) {
    if (length < 1) {
      throw ArgumentError('Length can not be smaller than 1');
    }
    if (text.isEmpty) {
      return false;
    }
    if (text.length != length) {
      return false;
    }
    return RegExp('^[0-9]{$length}\$').hasMatch(text);
  }

  /// Validates if a password meets specified security requirements.
  ///
  /// This function checks a password against several conditions such as the
  /// presence of uppercase letters, lowercase letters, digits, special characters,
  /// and a minimum length.
  ///
  /// Parameters:
  /// - [password]: The password string to validate.
  /// - [uppercaseRequired] (optional): Specifies if at least one uppercase letter
  ///   is required. Default is `true`.
  /// - [lowercaseRequired] (optional): Specifies if at least one lowercase letter
  ///   is required. Default is `true`.
  /// - [digitsRequired] (optional): Specifies if at least one numeric digit is required.
  ///   Default is `true`.
  /// - [specialCharRequired] (optional): Specifies if at least one special character
  ///   (e.g., @, $, !) is required. Default is `true`.
  /// - [minimumLength] (optional): Specifies the minimum length of the password.
  ///   Default is `8`.
  ///
  /// Returns:
  /// - `true` if the password meets all specified requirements.
  /// - `false` otherwise.
  ///
  /// Throws:
  /// - `ArgumentError` if [minimumLength] is less than 1.
  ///
  /// Example:
  /// ```dart
  /// bool isValid = General.isPasswordValid(
  ///   "Example@123",
  ///   minimumLength: 10,
  ///   uppercaseRequired: true,
  ///   specialCharRequired: true,
  /// );
  /// print(isValid); // true
  /// ```
  static bool isPasswordValid(
    String password, {
    bool uppercaseRequired = true,
    bool lowercaseRequired = true,
    bool digitsRequired = true,
    bool specialCharRequired = true,
    int minimumLength = 8,
  }) {
    if (minimumLength < 1) {
      throw ArgumentError('The length of password can not be smaller than 1');
    }
    final String uppercaseValidator = uppercaseRequired ? '(?=.*[A-Z])' : '';
    final String lowercaseValidator = lowercaseRequired ? '(?=.*[a-z])' : '';
    final String digitValidator = digitsRequired ? '(?=.*\\d)' : '';
    final String specialCharValidator =
        specialCharRequired ? '(?=.*[@\$_!%*?&])' : '';
    final String minCharsValidator = '[A-Za-z\\d@\$_!%*?&]{$minimumLength,}';
    final String rgx =
        '^$uppercaseValidator$lowercaseValidator$digitValidator$specialCharValidator$minCharsValidator\$';
    final regex = RegExp(rgx);
    return regex.hasMatch(password);
  }

  static const String _halfSpace = '\u200C';

  /// Removes all half-spaces (zero-width non-joiner) from the given string.
  ///
  /// Parameters:
  /// - [input]: A string potentially containing half-spaces to remove.
  ///
  /// Returns:
  /// - A new string with all half-spaces removed.
  ///
  /// Notes:
  /// - Half-space characters are commonly used in Persian text as zero-width non-joiners.
  /// - The half-space character is represented by `U+200C` (Zero Width Non-Joiner).
  ///
  /// Example:
  /// ```dart
  /// String cleaned = General.removeHalfSpaces("سلام‌علیکم"); // "سلامعلیکم"
  /// ```
  static String removeHalfSpaces(String input) {
    return input.replaceAll(_halfSpace, '');
  }

  /// Replaces all spaces in the given string with half-spaces (zero-width non-joiners).
  ///
  /// Parameters:
  /// - [input]: A string where spaces should be replaced with half-spaces.
  ///
  /// Returns:
  /// - A new string with spaces replaced by half-spaces.
  ///
  /// Notes:
  /// - Half-space characters are commonly used in Persian text for better typographic layout.
  /// - The half-space character is represented by `U+200C` (Zero Width Non-Joiner).
  ///
  /// Example:
  /// ```dart
  /// String formatted = General.replaceSpacesWithHalfSpaces("سلام علیکم"); // "سلام‌علیکم"
  /// ```
  static String replaceSpacesWithHalfSpaces(String input) {
    return input.replaceAll(' ', _halfSpace);
  }

  /// Replaces all half-spaces (zero-width non-joiners) in the given string with regular spaces.
  ///
  /// Parameters:
  /// - [input]: A string where half-spaces should be replaced with regular spaces.
  ///
  /// Returns:
  /// - A new string with half-spaces replaced by regular spaces.
  ///
  /// Notes:
  /// - The half-space character is represented by `U+200C` (Zero Width Non-Joiner).
  /// - This function is useful for normalizing Persian text for cases where regular spaces are preferred.
  ///
  /// Example:
  /// ```dart
  /// String normalized = General.replaceHalfSpacesWithSpaces("سلام‌علیکم"); // "سلام علیکم"
  /// ```
  static String replaceHalfSpacesWithSpaces(String input) {
    return input.replaceAll(_halfSpace, ' ');
  }
}

const List<String> _ones = [
  "",
  "یک",
  "دو",
  "سه",
  "چهار",
  "پنج",
  "شش",
  "هفت",
  "هشت",
  "نه"
];

const List<String> _teens = [
  "ده",
  "یازده",
  "دوازده",
  "سیزده",
  "چهارده",
  "پانزده",
  "شانزده",
  "هفده",
  "هجده",
  "نوزده"
];

const List<String> _tens = [
  "",
  "ده",
  "بیست",
  "سی",
  "چهل",
  "پنجاه",
  "شصت",
  "هفتاد",
  "هشتاد",
  "نود"
];

const List<String> _hundreds = [
  "",
  "یکصد",
  "دویست",
  "سیصد",
  "چهارصد",
  "پانصد",
  "ششصد",
  "هفتصد",
  "هشتصد",
  "نهصد"
];
