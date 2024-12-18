![](https://github.com/MohammadTaghipour/pars_validator/blob/master/img/logo.png)


# **ParsValidator**
**ParsValidator** is a robust and lightweight validation library designed specifically for Persian-speaking developers building Flutter applications. It provides a suite of utilities and tools to validate Persian-specific data formats, including national codes, phone numbers, Shamsi dates, bank card numbers, and more.

## ✨ Features

#### National ID utilities:
- Validate an Iranian National ID
- Generate a random valid Iranian National ID
- Get the issuance location of a National ID


## ⚙ Platform Support

| 📱 Android | 🍎 iOS | 🍏 MacOS | 🌐 Web | 🐧 Linux | 💻 Windows |
|:----------:|:------:|:--------:|:------:|:--------:|:----------:|
|     ✅      |   ✅    |    ✅     |   ✅    |    ✅     |     ✅      |

## 📦 Installation

To use this package, add it to your `pubspec.yaml` file:

```yaml
dependencies:
  pars_validator: ^0.1.0
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

## 🤝 Contributing

Contributions are welcome! If you'd like to contribute, feel free to open a pull request or submit
an issue.

## 🛡️ License

This project is licensed under the [MIT License](https://mit-license.org/).

## 📧 Contact

For questions, feedback, or support, please reach out:

- **Developer**: Mohammad Taghipour
- **Email**: taghipourmohammad7@gmail.com
