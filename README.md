<div align="center">

![](https://github.com/MohammadTaghipour/pars_validator/blob/master/img/logo.png)

[![English](https://img.shields.io/badge/Language-English-blueviolet?style=for-the-badge)](README.md)
[![Persian](https://img.shields.io/badge/Language-Persian-blueviolet?style=for-the-badge)](README-fa.md)  


[![pub package](https://img.shields.io/pub/v/pars_validator.svg?label=pars_validator&color=blue)](https://pub.dev/packages/pars_validator)
[![popularity](https://img.shields.io/pub/popularity/pars_validator?logo=dart)](https://pub.dev/packages/pars_validator/score)
[![likes](https://img.shields.io/pub/likes/pars_validator?logo=dart)](https://pub.dev/packages/pars_validator/score)
[![pub points](https://img.shields.io/pub/points/pars_validator?logo=dart)](https://pub.dev/packages/get/score)
[![style: effective dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://pub.dev/packages/effective_dart)
[![Telegram](https://img.shields.io/badge/text-on%20Telegram-blue.svg)](https://t.me/taghipour_dev)
</div>


# ParsValidator
**ParsValidator** is a robust and lightweight validation library designed specifically for Persian-speaking developers building Flutter applications. It provides a suite of utilities and tools to validate Persian-specific data formats, including national codes, phone numbers, Shamsi dates, bank card numbers, and more.

## ✨ Features

#### 🌌 General text utilities:

- Check that a text contains only Persian letters
- Validate the word count of a given text
- Count the number of words in a given text
- Convert a text to Persian format, replacing Arabic characters and English digits
- Convert Persian and Arabic digits in a text to English digits
- Convert number to Persian letters
- Convert number to Persian price in Tomans
- Separate numbers and strings with a custom count and separator
- Validate OTP codes
- Validate passwords with customizable parameters

#### 🌏 National utilities:

- Validate an Iranian National ID
- Generate a random valid Iranian National ID
- Get the issuance location of a National ID
- Validate Iranian postal code
- Validate Iranian company national ID

#### 🏦 Bank utilities:

- Validate credit card number
- Format credit card number
- Validate IBAN (Shaba)
- Get the name or icon of a card number

#### ☎ 📱 Telephone & Mobile number & Email utilities:

- Validate landline and mobile number formats
- Get the province of a landline number
- Get the operator name or icon of a mobile number
- Validate Email address with standard format

## ⚙ Platform Support

| 📱 Android | 🍎 iOS | 🍏 MacOS | 🌐 Web | 🐧 Linux | 💻 Windows |
|:----------:|:------:|:--------:|:------:|:--------:|:----------:|
|     ✅      |   ✅    |    ✅     |   ✅    |    ✅     |     ✅      |

## 📦 Installation

To use this package, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  pars_validator: ^0.5.5
```

Then, run the following command to fetch the package:

```bash
flutter pub get
```

Import the package in your project:

```dart
import 'package:pars_validator/pars_validator.dart';
```


## 📚 Usage

### 🌌 General text utilities:

```dart
// Check that a text contains only Persian letters
bool isValid = General.onlyPersianLetters('سلام دنیا'); // true

// Validate the word count of a given text
bool isValid = General.validateWordCount('سلام دنیا', 1, 3); // true

// Count the number of words in a given text
int wordCount = General.getWordCount('Hello World!'); // 2

// Convert a text to Persian format, replacing Arabic characters and English digits
String converted = General.arabicToPersian('اراك'); // اراک
String converted = General.englishToPersianNumbers('123'); // '۱۲۳'
String converted = General.toPersian('123 كلمه'); // '۱۲۳ کلمه'

// Convert Persian and Arabic digits in a text to English digits
String converted = General.toEnglishNumbers('۱۲۳۴'); // '1234'

// Convert number to Persian letters
// result:  'یک صد و بیست و سه میلیون چهار صد و پنجاه و شش هزار هفت صد و هشتاد و نه'
String result = General.numberToLetters(123456789);

// Convert number to price
String price = General.numberToPrice(
    1234567890); // خروجی: ۱۲ میلیون و ۳۴۵ هزار و ۶۷۸ تومان و ۹ ریال

// Separate numbers and strings with a custom count and separator
String result = General.separate("123456789", splitter: ',', groupSize: 3); // "123,456,789"

// Validate OTP
bool isValid = General.isOTPValid("123456", 6); // true

// Check password validation
bool isValid = General.isPasswordValid(
  "Example@123",
  minimumLength: 10,
  uppercaseRequired: true,
  specialCharRequired: true,
); // true
```

### 🌏 National utilities
```dart
// check national id validation
bool isValid = National.isNationalIDValid("1234567890"); // false

// generate a random valid national id
String natId = National.generateRandomID(); // 0714265411

// get the issuance location of a National ID
String? issuance = National.getIssuance("1642459372"); // سراب

// validate Iranian postal code
bool isValid = National.isValidPostalCode("1918934354"); // true

// Validate Iranian company national ID
bool isValid = National.isLegalNationalID('10380284790'); // true
```

### 🏦 Bank

```dart
// check card number validation
bool isValid = Banker.isCardNumberValid('1234567812345670'); // false

// format a card number
String formatted = Banker.formatCardNumber('1234567812345670'); // '1234 5678 1234 5670'

// check IBAN (Shaba) validation
bool isValid = Banker.isIBANValid('IR820540102680020817909007'); // true

// get the bank name of a card number
String? bankName = Banker.getBankNameByCardNumber('6274129005473742'); // اقتصاد نوین

// get the bank icon of a card number
Widget? bankIcon = Banker.getIcon('6274129005473742'); // svg icon of Eghtesad Novin bank
```

### ☎ 📱 Telephone & Mobile number & Email

```dart
// check mobile number validation
bool isValid = Phone.isMobileNumberValid('+98 912 345 6789'); // true

// check landline number validation
bool isValid = Phone.isLandlineNumberValid('021 1234 5678'); // true

// get the province name of a landline number
String? landlineProvince = Phone.getLandlineNumberProvince('021 1234 5678'); // 'تهران'

// get the operator of a mobile number
String? operatorName = Phone.getMobileOperator('+98 912 345 6789'); // 'همراه اول'

// get the operator icon of a mobile number
Widget? operatorIcon = Phone.getMobileOperatorIcon('+98 912 345 6789'); // Hamrah-Avval icon widget

// Validate an email address with standard email format
bool isValid = Phone.isEmailValid('example@domain.com'); // true
```

### 🛠 Also with Extensions

```dart
// check national id validation
bool isValid = '1234567890'.isNationalIDValid(); // false

// get the issuance location of a National ID
String? issuance = '1642459372'.getIssuanceOfNationalID(); // سراب

// check IBAN (Shaba) validation
bool isValid = 'IR820540102680020817909007'.isIBANValid(); // true

// and all other functions...
```

## 🤝 Contributing

Contributions are welcome! If you'd like to contribute, feel free to open a pull request or submit
an issue.

## 🛡️ License

This project is licensed under the [MIT License](https://mit-license.org/).

## 📧 Contact

For questions, feedback, or support, please reach out:

- **Developer**: Mohammad Taghipour
- **Email**: taghipourmohammad7@gmail.com
