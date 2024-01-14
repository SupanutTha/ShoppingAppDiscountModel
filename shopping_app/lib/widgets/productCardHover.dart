import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';

class ProductCardHover extends StatefulWidget {
  final String productName;
  final ProductCategory productCategory;
  final double productPrice;
  final String image;
  final Function() onTap;

  const ProductCardHover({
    Key? key,
    required this.productName,
    required this.productCategory,
    required this.productPrice,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  _ProductCardHoverState createState() => _ProductCardHoverState();
}

class _ProductCardHoverState extends State<ProductCardHover> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double borderRadius = 16.0;

    return Padding(
      padding: EdgeInsets.all(4),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: InkWell(
          onTap: widget.onTap,
          child: Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: SizedBox(
                width: width / 10,
                height: height / 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        widget.image,
                        fit: BoxFit.fitHeight,
                        height: height / 6,
                        width: width / 2,
                      ),
                      Text(
                        widget.productName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.productCategory.title),
                      Text(
                        widget.productPrice.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
