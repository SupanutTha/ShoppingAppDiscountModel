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
    double totalPrice = productViewModel.calculateGrandTotal(cartItems);
    
    checkoutCart = productViewModel.deepCopy(cartItems);
    for (var campaign in campaignList) {

      switch (campaign.subType) {
        case SubDiscountType.fixed:
          totalPrice = applyFixedDiscount(campaign, totalPrice);
          totalFix = campaign.value;
          break;

        case SubDiscountType.percentage:
          double beforeDiscountPrice = totalPrice;
          totalPrice = applyPercentageDiscount(campaign,totalPrice);
          totalPercentage = beforeDiscountPrice - totalPrice;
          break;

        case SubDiscountType.percentageByCategory:
          totalPrice = applyPercentageByCategoryDiscount(campaign, totalPrice, cartItems);
          break;

        case SubDiscountType.points:
          totalPrice = applyPointsDiscount(campaign, totalPrice);
          break;

        case SubDiscountType.special:
          totalPrice = applySpecialDiscount(campaign,totalPrice);
          break;
      }
    }
    totalPriceAfterDiscount = totalPrice;
    if (totalPriceAfterDiscount <= 0) {
      totalPriceAfterDiscount = 0;
    }
    return totalPrice;
  }

   double applyFixedDiscount(Discount campaign, double totalPrice) {
    totalPrice -= campaign.value;
    totalFix = campaign.value;
    return totalPrice;
  }

  double applyPercentageDiscount(Discount campaign,double totalPrice) {
    double beforeDiscountPrice = totalPrice;
    
    for (var item in checkoutCart) {
      double discountedPrice = item.price * (1 - campaign.value / 100);
      item.price = discountedPrice;
    }
    
    totalPrice = productViewModel.calculateGrandTotal(checkoutCart);
    totalPercentage = beforeDiscountPrice - totalPrice;
    return totalPrice;
  }

  double applyPercentageByCategoryDiscount(Discount campaign, double totalPrice, List<Product> cartItems) {
    double totalDiscountPriceFormPercentage = 0;


      for (var item in checkoutCart) {
         print(campaign.value[SpecialDiscountValue.category]);
        if (item.category == campaign.value[SpecialDiscountValue.category]) {
          totalPrice -= item.price * (campaign.value[SpecialDiscountValue.amount] / 100);
          totalDiscountPriceFormPercentage +=
              item.price * item.qty * (campaign.value[SpecialDiscountValue.amount] / 100);
        }
      }
    

    totalPercentageCategory = totalDiscountPriceFormPercentage;
    return totalPrice;
}


  double applyPointsDiscount(Discount campaign, double totalPrice) {
    double limit = totalPrice * 0.2;
    double appliedDiscount = min(campaign.value, limit);
    totalPrice -= appliedDiscount;
    totalPoints = appliedDiscount;
    return totalPrice;
  }

  double applySpecialDiscount(Discount campaign, double totalPrice) {
    int discountTime = totalPrice ~/ campaign.value[SpecialDiscountValue.specialCampaignThreshold];
    totalPrice -= discountTime * campaign.value[SpecialDiscountValue.specialCampaignFixedDiscount];
    totalSeasonal = discountTime * campaign.value[SpecialDiscountValue.specialCampaignFixedDiscount] as double;
    return totalPrice;
  }


  double getDiscountInfo(Discount discount) {
    switch (discount.subType) {
      case SubDiscountType.fixed:
        return totalFix;
      case SubDiscountType.percentage:
        return totalPercentage;
      case SubDiscountType.percentageByCategory:
        return totalPercentageCategory;
      case SubDiscountType.points:
        return totalPoints;
      case SubDiscountType.special:
        return totalSeasonal;
      default:
        return 0;
    }
  }

  void removeDiscountByType(DiscountType type) {
  campaignApply.removeWhere((discount) => discount.type == type);
}
}
