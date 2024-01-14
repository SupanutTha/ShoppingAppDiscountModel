import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final ProductCategory productCategory;
  final String productImage;
  final double productPrice;
  final Function() onTap;

  ProductCard({ 
    required this.onTap, 
    required this.productName, 
    required this.productCategory, 
    required this.productImage, 
    required this.productPrice});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
       child: GridTile(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage(productImage),
            ),
          ),
        ),
        footer: Container(
          color: Colors.black54,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "${productName}",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(productCategory.title, style: TextStyle(fontSize: 16, color: Colors.white)),
                Text(productPrice.toString(), style: TextStyle(fontSize: 16, color: Colors.white))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
