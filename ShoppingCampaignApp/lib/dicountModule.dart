import 'dart:math';

import 'discountCampaign.dart';
import 'productModel.dart';

class DiscountModule{
  double totalFix = 0;
  double totalPercentage = 0;
  double totalPercentageCategory = 0;
  double totalPoints = 0;
  double totalSeasonal = 0;
  double totalPriceAfterDiscount = 0;
  List<Product> discountCart = [];

  DiscountModule(List<Product> cartItems, List<Discount> campaigns) {
    applyDiscount(cartItems, campaigns);
  }
  double applyDiscount(List<Product> cartItems, List<Discount> campaigns) {
    double totalPrice = calculateGrandTotal(cartItems);
    print("check");
    discountCart = CartHelper.deepCopy(cartItems);
    print(discountCart);
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
          double beforeDiscountPrice = totalPrice;
          for (var item in discountCart ){
            double discountedPrice  = item.price *  (1 - campaign.value / 100);
            item.price  = discountedPrice;
          }
          totalPrice = calculateGrandTotal(discountCart);
          totalPercentage = beforeDiscountPrice - totalPrice;
          break;

        case 'PercentageDiscountByCategory':
          double beforeDiscountPrice = totalPrice;
          double totalDicountPriceFormPresentage= 0;
          if (discountCart.isEmpty){
            for (var item in cartItems ){
              if(item.category == campaign.value['category']){
                totalPrice -= item.price*(campaign.value['amount'] / 100);
                totalDicountPriceFormPresentage +=item.price*(campaign.value['amount'] / 100);
              }
          }
          }
          else{
            for (var item in discountCart ){
              if(item.category == campaign.value['category']){
                totalPrice -= item.price*(campaign.value['amount'] / 100);
                totalDicountPriceFormPresentage +=item.price*(campaign.value['amount'] / 100);
              }
          }
          }

          totalPercentageCategory = totalDicountPriceFormPresentage;
          break;

        case 'DiscountByPoints':
          double limit = totalPrice*0.2;
          double appliedDiscount = min(campaign.value, limit);
          totalPrice -= appliedDiscount;
          totalPoints = appliedDiscount;
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
    if (totalPriceAfterDiscount <= 0){
      print("check");
      totalPriceAfterDiscount = 0;
    }
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
