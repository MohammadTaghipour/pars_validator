import 'package:pars_validator/pars_validator.dart';

extension StringValidation on String {
  // NationalID ----------

  bool isNationalIDValid() {
    return NationalID.isNationalIDValid(this);
  }

  String generateRandomNationalID() {
    return NationalID.generateRandomID();
  }

  String? getIssuanceOfNationalID() {
    return NationalID.getIssuance(this);
  }

  // Banker ----------

  bool isCardNumberValid() {
    return Banker.isCardNumberValid(this);
  }

  String formatCardNumber({
    String splitter = ' ',
    int groupSize = 4,
  }) {
    return Banker.formatCardNumber(this,
        groupSize: groupSize, splitter: splitter);
  }

  bool isIBANValid() {
    return Banker.isIBANValid(this);
  }
}
