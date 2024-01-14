import '../models/product.dart';
import 'package:collection/collection.dart';

class ProductViewModel {
  final List<Product> _products = [
    Product(
        id: 1,
        name: "T-Shirt",
        category: ProductCategory.clothing,
        qty: 1,
        price: 350,
        image: "../images/t-shirt.jpeg"),
    Product(
        id: 2,
        name: "Hat",
        category: ProductCategory.clothing,
        qty: 1,
        price: 250,
        image: "../images/hat.jpeg"),
    Product(
        id: 3,
        name: "Watch",
        category: ProductCategory.accessories,
        qty: 1,
        price: 850,
        image: "../images/watch.png"),
    Product(
        id: 4,
        name: "Bag",
        category: ProductCategory.accessories,
        qty: 1,
        price: 640,
        image: "../images/bag.jpeg"),
    Product(
        id: 5,
        name: "Printer",
        category: ProductCategory.electronics,
        qty: 1,
        price: 1500,
        image: "../images/printer.png"),
  ];

  List<Product> userCart = [];

  double calculateGrandTotal(List<Product> cartItems) {
    return cartItems.fold(0.0, (sum, item) => sum + (item.price * item.qty));
  }

  void addProductToCart(Product product) {
    var check = userCart.firstWhereOrNull((p) => p.id == product.id);
    if (check == null) {
      userCart.add(product);
      //print(cart);
    } else {
      check.qty += 1;
    }
  } //ef

  void removeFromCart(Product product) {
    if (product.qty - 1 == 0) {
      userCart.remove(product);
    } else {
      product.qty -= 1;
    }
  }

  void clearCart() {
    userCart.clear();
  }

  List<Product> deepCopy(List<Product> original) {
    List<Product> copy = [];
    for (var item in original) {
      copy.add(Product(
        id: item.id,
        name: item.name,
        category: item.category,
        qty: item.qty,
        price: item.price,
        image: item.image,
      ));
    }
    return copy;
  }
}