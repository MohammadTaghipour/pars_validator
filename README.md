![](https://github.com/MohammadTaghipour/pars_validator/blob/master/img/logo.png)


# **ParsValidator**
**ParsValidator** is a robust and lightweight validation library designed specifically for Persian-speaking developers building Flutter applications. It provides a suite of utilities and tools to validate Persian-specific data formats, including national codes, phone numbers, Shamsi dates, bank card numbers, and more.

## ✨ Features

#### National ID utilities:
- Validate an Iranian National ID
- Generate a random valid Iranian National ID
- Get the issuance location of a National ID

#### Bank utilities:

- Validate credit card number
- Format credit card number
- Validate IBAN (Shaba)
- Get the name or icon of a card number


## ⚙ Platform Support

| 📱 Android | 🍎 iOS | 🍏 MacOS | 🌐 Web | 🐧 Linux | 💻 Windows |
|:----------:|:------:|:--------:|:------:|:--------:|:----------:|
|     ✅      |   ✅    |    ✅     |   ✅    |    ✅     |     ✅      |

## 📦 Installation

To use this package, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  pars_validator: ^0.3.1
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

### National ID
```dart
// check national id validation
bool isValid = NationalID.isNationalIDValid("1234567890"); // false

// generate a random valid national id
String natId = NationalID.generateRandomID(); // 0714265411

// get the issuance location of a National ID
String? issuance = NationalID.getIssuance("1642459372"); // سراب
```

### Bank

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

### Also with Extensions

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
