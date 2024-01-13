enum ProductCategory {
  clothing,
  accessories,
  electronics,

}

String categoryTitle(ProductCategory category) {
  switch (category) {
    case ProductCategory.clothing:
      return "Clothing";
    case ProductCategory.accessories:
      return "Accessories";
    case ProductCategory.electronics:
      return "Electronics";
  }
}


class Product {
  int id;
  String name;
  int qty;
  double price;
  String image;
  ProductCategory category;
  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.qty,
    required this.price,
    required this.image,
  });
}

List<Product> products = [
  Product(
    id: 1,
    name: "T-Shirt",
    category: ProductCategory.clothing,
    qty: 1,
    price: 350,
    image: "../images/t-shirt.jpeg",
  ),
  Product(
    id: 2,
    name: "Hat",
    category: ProductCategory.clothing,
    qty: 1,
    price: 250,
    image: "../images/hat.jpeg",
  ),
  Product(
    id: 3,
    name: "Watch",
    category: ProductCategory.accessories,
    qty: 1,
    price: 850,
    image: "../images/watch.png",
  ),
  Product(
    id: 4,
    name: "Bag",
    category: ProductCategory.accessories,
    qty: 1,
    price: 640,
    image: "../images/bag.jpeg",
  ),
  Product(
    id: 5,
    name: "Printer",
    category: ProductCategory.electronics,
    qty: 1,
    price: 1500,
    image: "../images/printer.png",
  ),
];
