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
      id: 1, name: "T-Shirt",category: "Clothing", qty: 1, price: 350, picture: "images/food1.jpeg"),
  Product(
      id: 2, name: "Hat",category: "Clothing", qty: 1, price: 250, picture: "images/food2.jpeg"),
  Product(
      id: 3, name: "Watch",category: "Accessories", qty: 1, price: 850, picture: "images/food3.jpeg"),
  Product(
      id: 4, name: "Bag",category: "Accessories", qty: 1, price: 640, picture: "images/food4.jpeg"),
  Product(
      id: 5, name: "Printer",category: "Electronics", qty: 1, price: 1500, picture: "images/food4.jpeg"),
  
];

//create a new variable to hold product in the cart/basket
List<Product> cart = [
];

double grandTotal = 0;