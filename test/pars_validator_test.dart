import 'package:pars_validator/pars_validator.dart';

void main() {
  bool isValid = General.isPasswordValid(
    "Example@123",
    minimumLength: 10,
    uppercaseRequired: true,
    specialCharRequired: true,
  );
  print(isValid); // true
}
