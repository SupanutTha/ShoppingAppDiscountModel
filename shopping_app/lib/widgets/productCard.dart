import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';

class ProductCard extends StatefulWidget {
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
    required this.productPrice,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () {
          widget.onTap();
        },
        child: GridTile(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage(widget.productImage),
              ),
            ),
          ),
          footer: Container(
            color: isHovered ? Colors.black87 : Colors.black54,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "${widget.productName}",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    widget.productCategory.title,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    widget.productPrice.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
