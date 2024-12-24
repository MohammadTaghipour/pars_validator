class Bank {
  final String _name;
  final List<String> _cardPrefixes;
  final String _iconPath;

  Bank(
      {required String name,
      required List<String> cardPrefixes,
      required String iconPath})
      : _name = name,
        _cardPrefixes = cardPrefixes,
        _iconPath = iconPath;

  String get iconPath => _iconPath;

  List<String> get cardPrefixes => _cardPrefixes;

  String get name => _name;
}
