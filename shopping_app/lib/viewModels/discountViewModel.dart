import 'dart:math';
import '../models/discount.dart';
import '../models/product.dart';
import 'productViewModel.dart';

class DiscountViewModel {
  double totalFix = 0;
  double totalPercentage = 0;
  double totalPercentageCategory = 0;
  double totalPoints = 0;
  double totalSeasonal = 0;
  double totalPriceAfterDiscount = 0;
  List<Product> checkoutCart = [];
  List<Discount> campaignApply = [];

  ProductViewModel productViewModel = ProductViewModel();

  double applyDiscount(List<Product> cartItems, List<Discount> campaignList) {
    print("test cast in discount : $cartItems");
    checkoutCart = productViewModel.deepCopy(cartItems);
    print("test cast in deep copy discount : $cartItems");
    double totalPrice = productViewModel.calculateGrandTotal(checkoutCart);
    print(" total price = $totalPrice");
    
    
    for (var campaign in campaignList) {
      print(campaign.type);
      print(campaign.value);
      print(totalPrice);

      switch (campaign.subType) {
        case SubDiscountType.fixed:
          totalPrice -= campaign.value;
          totalFix = campaign.value;
          break;

        case SubDiscountType.percentage:
          double beforeDiscountPrice = totalPrice;
          for (var item in checkoutCart) {
            double discountedPrice = item.price * (1 - campaign.value / 100);
            item.price = discountedPrice;
          }
          totalPrice = productViewModel.calculateGrandTotal(checkoutCart);
          totalPercentage = beforeDiscountPrice - totalPrice;
          break;

        case SubDiscountType.percentageByCategory:
          double beforeDiscountPrice = totalPrice;
          double totalDiscountPriceFormPercentage = 0;
          if (checkoutCart.isEmpty) {
            for (var item in cartItems) {
              if (item.category == campaign.value['category']) {
                totalPrice -=
                    item.price * (campaign.value['amount'] / 100);
                totalDiscountPriceFormPercentage +=
                    item.price * item.qty * (campaign.value['amount'] / 100);
              }
            }
          } else {
            for (var item in checkoutCart) {
              if (item.category == campaign.value['category']) {
                totalPrice -=
                    item.price * (campaign.value['amount'] / 100);
                totalDiscountPriceFormPercentage +=
                    item.price * item.qty * (campaign.value['amount'] / 100);
              }
            }
          }

          totalPercentageCategory = totalDiscountPriceFormPercentage;
          break;

        case SubDiscountType.points:
          double limit = totalPrice * 0.2;
          double appliedDiscount = min(campaign.value, limit);
          totalPrice -= appliedDiscount;
          totalPoints = appliedDiscount;
          break;
        case SubDiscountType.special:
          print(campaign.value['everyX']);
          print(campaign.value['discountY']);
          print(totalPrice % campaign.value['everyX']);
          int discountTime = totalPrice ~/ campaign.value['everyX'];
          totalPrice -= discountTime * campaign.value['discountY'];
          totalSeasonal = discountTime * campaign.value['discountY'] as double;
          break;
      }
      print("after discount $totalPrice");
    }
    totalPriceAfterDiscount = totalPrice;
    // if (totalPriceAfterDiscount <= 0) {
    //   print("check");
    //   totalPriceAfterDiscount = 0;
    // }
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
