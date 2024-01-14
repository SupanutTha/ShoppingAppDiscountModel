enum DiscountType {
  coupon,
  onTop,
  seasonal;

  String get title {
    switch(this){
      case DiscountType.coupon:
      return "Coupon Campaign";
    case DiscountType.onTop:
      return "On Top Campaign";
    case DiscountType.seasonal:
      return "Seasonal Campaign";
    }
  }
}


enum SubDiscountType {
  fixed,
  percentage,
  percentageByCategory,
  points,
  special;
  
  String get title{
    switch(this){
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
}

enum SpecialDiscountValue{
  category,
  amount,
  specialCampaignThreshold,
  specialCampaignFixedDiscount;

  String get title{
    switch(this){
      case SpecialDiscountValue.category:
        return "category";
      case SpecialDiscountValue.amount:
        return "amount";
      case SpecialDiscountValue.specialCampaignThreshold:
        return "Special Campaign Threshold";
      case SpecialDiscountValue.specialCampaignFixedDiscount:
        return "special Campaign Fixed Discount";
    }
  }

}

class Discount {
  final DiscountType type;
  final SubDiscountType subType;
  final value;
  final bool apply;

  Discount({
    required this.type,
    required this.subType,
    required this.value,
    required this.apply
  });
}
