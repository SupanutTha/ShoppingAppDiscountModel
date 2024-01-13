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
        picture: "../images/t-shirt.jpeg"),
    Product(
        id: 2,
        name: "Hat",
        category: ProductCategory.clothing,
        qty: 1,
        price: 250,
        picture: "../images/hat.jpeg"),
    Product(
        id: 3,
        name: "Watch",
        category: ProductCategory.accessories,
        qty: 1,
        price: 850,
        picture: "../images/watch.png"),
    Product(
        id: 4,
        name: "Bag",
        category: ProductCategory.accessories,
        qty: 1,
        price: 640,
        picture: "../images/bag.jpeg"),
    Product(
        id: 5,
        name: "Printer",
        category: ProductCategory.electronics,
        qty: 1,
        price: 1500,
        picture: "../images/printer.png"),
  ];

  List<Product> _cart = [];

  double calculateGrandTotal(List<Product> cartItems) {
    return _cart.fold(0, (sum, item) => sum + (item.price * item.qty));
  }

  void addProductToCart(Product product) {
    var check = _cart.firstWhereOrNull((p) => p.id == product.id);
    if (check == null) {
      _cart.add(product);
      //print(cart);
    } else {
      check.qty += 1;
    }
  } //ef

  void removeFromCart(Product product) {
    if (product.qty - 1 == 0) {
      _cart.remove(product);
    } else {
      product.qty -= 1;
    }
  }

  void clearCart() {
    _cart.clear();
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
        picture: item.picture,
      ));
    }
    return copy;
  }
}