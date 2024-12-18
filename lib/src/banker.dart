class Banker {
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
    if (sum % 10 == 0) {
      return true;
    } else {
      return false;
    }
  }

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
