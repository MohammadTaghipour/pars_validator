import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pars_validator/pars_validator.dart';

class BankIcon extends StatelessWidget {
  final Bank bank;
  final double size;

  const BankIcon({
    super.key,
    required this.bank,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'packages/pars_validator/assets/icons/banks/${bank.iconPath}',
      width: size,
      height: size,
      fit: BoxFit.fitWidth,
    );
  }
}
