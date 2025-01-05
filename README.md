![](https://github.com/MohammadTaghipour/pars_validator/blob/master/img/logo.png)

# ParsValidator
**ParsValidator** is a robust and lightweight validation library designed specifically for Persian-speaking developers building Flutter applications. It provides a suite of utilities and tools to validate Persian-specific data formats, including national codes, phone numbers, Shamsi dates, bank card numbers, and more.

## ✨ Features

#### 🌌 General text utilities:

- Check that a text contains only Persian letters
- Validate the word count of a given text
- Count the number of words in a given text
- Convert a text to Persian format, replacing Arabic characters and English digits
- Convert Persian and Arabic digits in a text to English digits

#### 🌏 National ID utilities:
- Validate an Iranian National ID
- Generate a random valid Iranian National ID
- Get the issuance location of a National ID

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
  pars_validator: ^0.5.0
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
```

### 🌏 National ID
```dart
// check national id validation
bool isValid = NationalID.isNationalIDValid("1234567890"); // false

// generate a random valid national id
String natId = NationalID.generateRandomID(); // 0714265411

// get the issuance location of a National ID
String? issuance = NationalID.getIssuance("1642459372"); // سراب
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

// and much more...
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
