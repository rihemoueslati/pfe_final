import 'package:flutter/material.dart';
import 'package:forum_republique/models/Product.dart';

import '../../../constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  final Product product;

  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 150, width: 150,
        decoration: BoxDecoration(
          color: Color(0xFFFCFCFC),
          borderRadius: const BorderRadius.all(
            Radius.circular(defaultPadding * 1.25),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              offset: Offset(5, 5),
              color: Colors.red.withOpacity(0.1),
            ),
            BoxShadow(
              blurRadius: 3,
              offset: Offset(-5, -5),
              color: Colors.red.withOpacity(0.1),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: product.title!,
              child: Image.asset(product.image!),
            ),
            Text(
              product.title!,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.w600),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

            )
          ],
        ),
      ),
    );
  }
}
