import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pars_validator/pars_validator.dart';

class OperatorIcon extends StatelessWidget {
  final MobileOperator operator;
  final double size;

  const OperatorIcon({
    super.key,
    required this.operator,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'packages/pars_validator/assets/operators/icons/${operator.iconPath}',
      width: size,
      height: size,
      fit: BoxFit.fitWidth,
    );
  }
}
