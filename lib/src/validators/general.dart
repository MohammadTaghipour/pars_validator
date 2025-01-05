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
}
