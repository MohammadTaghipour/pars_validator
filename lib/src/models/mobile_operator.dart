class MobileOperator {
  final String _operator;
  final List<String> _numberCode;
  final String _iconPath;

  MobileOperator(
      {required String operator,
      required List<String> numberCode,
      required String iconPath})
      : _operator = operator,
        _numberCode = numberCode,
        _iconPath = iconPath;

  String get iconPath => _iconPath;

  List<String> get numberCode => _numberCode;

  String get operator => _operator;
}
