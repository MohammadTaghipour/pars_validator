<div align="center">

![](https://github.com/MohammadTaghipour/pars_validator/blob/master/img/logo.png)

[![English](https://img.shields.io/badge/Language-English-blueviolet?style=for-the-badge)](README.md)
[![Persian](https://img.shields.io/badge/Language-Persian-blueviolet?style=for-the-badge)](README-fa.md)  
  
</div>

# ParsValidator
یک کتابخانه اعتبارسنجی قدرتمند و سبک است که به‌طور ویژه برای توسعه‌دهندگان فارسی‌زبان در ساخت اپلیکیشن‌های فلاتر طراحی شده است. این کتابخانه مجموعه‌ای از ابزارها و امکانات را برای اعتبارسنجی فرمت‌های خاص داده‌ای فارسی ارائه می‌دهد، از جمله کد ملی، شماره تلفن، تاریخ‌های شمسی، شماره کارت‌های بانکی و موارد دیگر.

## ✨ ویژگی ها

#### 🌌 توابع عمومی متنی

- بررسی اینکه یک متن فقط حاوی حروف فارسی باشد
- اعتبارسنجی تعداد کلمات یک متن داده‌شده
- شمردن تعداد کلمات در یک متن داده‌شده
- تبدیل متن به فرمت فارسی، با جایگزینی حروف عربی و اعداد انگلیسی
- تبدیل اعداد فارسی و عربی در یک متن به اعداد انگلیسی
- تبدیل عدد به حروف فارسی
- تبدیل عدد به قیمت فارسی به تومان
- جدا کردن اعداد و رشته‌ها با تعداد و جداکننده دلخواه
- اعتبارسنجی کدهای OTP
- اعتبارسنجی پسوردها با پارامترهای قابل تنظیم

  
#### 🌏 توابع ملی
- اعتبارسنجی کد ملی ایرانی
- تولید یک کد ملی ایرانی معتبر به‌صورت تصادفی
- دریافت محل صدور کد ملی
- اعتبارسنجی کد پستی ایرانی
- اعتبارسنجی کد ملی شرکت‌های ایرانی

#### 🏦 توابع بانکی

- اعتبارسنجی شماره کارت
- فرمت شماره کارت و جداسازی رقم به رقم شماره کارت
- اعتبارسنجی شماره شبا
- دریافت نام و آیکون بانک براساس شماره کارت

#### ☎ 📱 توابع شماره تلفن و موبایل و ایمیل

- اعتبارسنجی تلفن خط ثابت و شماره موبایل
- دریافت نام استان شماره تلفن ثابت
- دریافت نام و آیکون اپراتور تلفن همراه
- اعتبارسنجی ایمیل با فرمت استاندارد

## ⚙ پلتفرم های پشتیبانی شده

| 📱 Android | 🍎 iOS | 🍏 MacOS | 🌐 Web | 🐧 Linux | 💻 Windows |
|:----------:|:------:|:--------:|:------:|:--------:|:----------:|
|     ✅      |   ✅    |    ✅     |   ✅    |    ✅     |     ✅      |

## 📦 نصب و راه اندازی

برای استفاده از این بسته، آن را به فایل `pubspec.yaml` خود اضافه کنید:

```yaml
dependencies:
  pars_validator: ^0.5.5
```

سپس، دستور زیر را برای دریافت بسته اجرا کنید:

```bash
flutter pub get
```

برای وارد کردن بسته به پروژه خود، از دستور زیر استفاده کنید:

```dart
import 'package:pars_validator/pars_validator.dart';
```


## 📚 نحوه استفاده

### 🌌 توابع متنی عمومی

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

### 🌏 توابع ملی
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

### 🏦 توابع بانکی

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

### ☎ 📱 توابع تلفن ثابت و تلفن همراه و ایمیل

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

### 🛠 همچنین میتوانید از اکستنشن ها نیز استفاده کنید...

```dart
// check national id validation
bool isValid = '1234567890'.isNationalIDValid(); // false

// get the issuance location of a National ID
String? issuance = '1642459372'.getIssuanceOfNationalID(); // سراب

// check IBAN (Shaba) validation
bool isValid = 'IR820540102680020817909007'.isIBANValid(); // true

// and all other functions...
```

## 🤝 مشارکت

اگر تمایل داشتید در توسعه و بهبود این کتابخانه مشارکت کنید بسیار خوشحال میشویم که یک pull request ایجاد کنید و یا اگر مشکلی در پکیج وجود داشت یک issue ثبت کنید تا حتما در اسرع وفت بررسی کنیم. قلب فراوان

## 🛡️ مجوز

این پروژه تحت مجوز [MIT License](https://mit-license.org/) توسعه داده شده است.

## 📧 تماس

برای سوالات، بازخورد یا پشتیبانی، لطفاً با ما تماس بگیرید:


- **توسعه دهنده**: محمد تقی پور
- **ایمیل**: taghipourmohammad7@gmail.com
