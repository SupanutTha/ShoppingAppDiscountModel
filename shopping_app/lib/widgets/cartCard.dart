// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../style.dart';

class CartCard extends StatefulWidget {
  final String productName;
  final ProductCategory category;
  final double price;
  final int qty;
  final String image;
  final Function() onTapAdd;
  final Function() onTapRemove;
  const CartCard({
    Key? key,
    required this.productName,
    required this.category,
    required this.price,
    required this.qty,
    required this.image, 
    required this.onTapAdd, 
    required this.onTapRemove,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardCardState();
}

class _CardCardState extends State<CartCard> {
  
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double borderRadius = 16.0;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: SizedBox(
            width: width / 3,
            height: height / 8,
            child: Row(
              children: [
                //image
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          widget.image,
                          fit: BoxFit.cover,
                          height: height/8 - 32,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.productName, style: cartBoxProductName),
                        Text(widget.category.title),
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text("${widget.price.toString()} THB"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            widget.onTapRemove();
                          },
                          icon: Icon(Icons.remove_circle_outline),
                        ),
                        Text(widget.qty.toString()),
                        IconButton(
                          onPressed: () {
                            widget.onTapAdd();
                          },
                          icon: Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
