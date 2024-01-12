class Discount {
  final String type;
  final dynamic value;
  final bool apply;
  double? discount;

  Discount({
    required this.type,
    required this.value,
    required this.apply,
    this.discount
  });

}
List<Discount> discounts = [];
