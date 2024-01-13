class Discount {
  final String type;
  final dynamic value;
  final bool apply;

  Discount({
    required this.type,
    required this.value,
    required this.apply,
  });

}
List<Discount> discounts = [];
