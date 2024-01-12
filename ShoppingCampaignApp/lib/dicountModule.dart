import 'discountCampaign.dart';
import 'productModel.dart';

class DiscountModule{
  double totalFix = 0;
  double totalPercentage = 0;
  double totalPercentageCategory = 0;
  double totalPoints = 0;
  double totalSeasonal = 0;
  double totalPriceAfterDiscount = 0;
  DiscountModule(List<Product> cartItems, List<Discount> campaigns) {
    applyDiscount(cartItems, campaigns);
  }
  double applyDiscount(List<Product> cartItems, List<Discount> campaigns) {
    double totalPrice = grandTotal;
    print("check");
    print(cartItems);
    for (var campaign in campaigns) {
      print(campaign.type);
      print(campaign.value);
      print(totalPrice);
      switch (campaign.type) {
        case 'FixedAmount':
          totalPrice -= campaign.value;
          totalFix = campaign.value;
          break;
        case 'PercentageDiscount':
          totalPrice *= (1 - campaign.value / 100);
          totalPercentage = totalPrice* (campaign.value /100);
          break;
        case 'PercentageDiscountByCategory':
          double beforeDiscountPrice = totalPrice;
          for (var item in cartItems ){
            if(item.category == campaign.value['category']){
              totalPrice -= item.price*(campaign.value['amount'] / 100);
            }
            totalPercentageCategory = beforeDiscountPrice - totalPrice;

          }
          break;
        case 'DiscountByPoints':
          double limit = totalPrice*0.2;
          if (campaign.value <= limit){
            totalPrice -= campaign.value;
            totalPoints = campaign.value;
          }
          else{
            totalPrice -= limit;
            totalPoints = limit;
          }
          break;
        case 'SpecialCampaigns':
          print(campaign.value['everyX']);
          print(campaign.value['discountY']);
          print(totalPrice % campaign.value['everyX']);
          int discountTime = totalPrice ~/ campaign.value['everyX'];
          totalPrice -= discountTime*campaign.value['discountY'];
          totalSeasonal = discountTime*campaign.value['discountY'] as double;
          break;
      }
      print("after discount $totalPrice");
    }
    totalPriceAfterDiscount = totalPrice;
    return totalPrice;
  }
  double getDiscountInfo(Discount discount) {
  switch (discount.type) {
    case 'FixedAmount':
      return totalFix;
    case 'PercentageDiscount':
      return totalPercentage;
    case 'PercentageDiscountByCategory':
      return totalPercentageCategory;
    case 'DiscountByPoints':
      return totalPoints;
    case 'SpecialCampaigns':
      return totalSeasonal;
    default:
      return 0;
  }
}

}
