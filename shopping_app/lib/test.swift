struct Discount {
    let type: DiscountType
}


enum DiscountType {
    case coupon
    case onTop
    case seasonal

    var title: String {
        switch self {
        case coupon:
            return "Coupon"
        }
    }

    var subDiscount: [SubDiscountType] {
        switch self {
        case coupon:
            return [.fixed, .percentage]
        }
    }
}

enum SubDiscountType  {
 case fixed
 case percentage
 case ..
 case ..
}