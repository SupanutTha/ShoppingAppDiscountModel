class Product {
  int id;
  String name;
  int qty;
  double price;
  String picture;
  String category;
  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.qty,
    required this.price,
    required this.picture,
  });
}

List<Product> products = [
  Product(
      id: 1, name: "T-Shirt",category: "Clothing", qty: 1, price: 350, picture: "../images/t-shirt.jpeg"),
  Product(
      id: 2, name: "Hat",category: "Clothing", qty: 1, price: 250, picture: "../images/hat.jpeg"),
  Product(
      id: 3, name: "Watch",category: "Accessories", qty: 1, price: 850, picture: "../images/watch.png"),
  Product(
      id: 4, name: "Bag",category: "Accessories", qty: 1, price: 640, picture: "../images/bag.jpeg"),
  Product(
      id: 5, name: "Printer",category: "Electronics", qty: 1, price: 1500, picture: "../images/printer.png"),
  
];

//create a new variable to hold product in the cart/basket
List<Product> cart = [
];

double calculateGrandTotal(List<Product> cart) {
  return cart.fold(0, (sum, item) => sum + item.price);
}

double grandTotal = calculateGrandTotal(cart);

class CartHelper {
  static List<Product> deepCopy(List<Product> original) {
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