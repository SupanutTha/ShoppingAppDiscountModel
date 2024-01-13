enum DiscountType {
  coupon,
  onTop,
  seasonal,
}

String discountTypeTitle (DiscountType type){
  switch(type){
    case DiscountType.coupon:
      return "Coupon Campaign";
    case DiscountType.onTop:
      return "On Top Campaign";
    case DiscountType.seasonal:
      return "Seasonal Campaign";
    }
      
  }

enum SubDiscountType {
  fixed,
  percentage,
  percentageByCategory,
  points,
  special
}

String subDiscountTypeTitle ( SubDiscountType subType){
  switch(subType){
    case SubDiscountType.fixed:
      return "Fixed Amount";
    case SubDiscountType.percentage:
      return "Percentage Discount";
    case SubDiscountType.percentageByCategory:
      return "Percentage Discount By Item Category";
    case SubDiscountType.points:
      return "Discount By Points";
    case SubDiscountType.special:
      return "Special Campaign";
  }
}

class Discount {
  final DiscountType type;
  final bool apply;

  Discount({
    required this.type,
    required this.apply
  });
}
