import 'package:flutter/material.dart';
import 'package:shopping_app/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(Product) onTap;

  ProductCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(product);
      },
       child: GridTile(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage(product.image),
            ),
          ),
        ),
        footer: Container(
          color: Colors.black54,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${product.name} ${product.price}",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
      // child: Stack(
      //   children: [
      //     Container(
      //       decoration: BoxDecoration(
      //         image: DecorationImage(
      //           fit: BoxFit.cover,
      //           image: AssetImage(product.image),
      //         ),
      //       ),
      //     ),
          
          // Positioned.fill(
          //   child: Align(
          //     alignment: Alignment.bottomCenter,
          //     child: Container(
          //       color: Colors.black54,
          //       child: Padding(
          //         padding: const EdgeInsets.all(5.0),
          //         child: Text(
          //           "${product.name} ${product.price}",
          //           style: TextStyle(fontSize: 20, color: Colors.white60),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        //],
      //),
    );
  }
}
