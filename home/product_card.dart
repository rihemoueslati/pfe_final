
import 'package:flutter/material.dart';
import 'package:forum_republique/Components/fav_btn.dart';
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
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        decoration: BoxDecoration(
          color: Color(0xFFF7F7F7),
          borderRadius: const BorderRadius.all(
            Radius.circular(defaultPadding * 1.25),
          ),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                offset: Offset(5,5),
                color: Colors.red,
              ),
              BoxShadow(
                blurRadius: 3,
                offset: Offset(-5,-5),
                color: Colors.red,
              ),
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Text(
              "Fruits",
              style: Theme.of(context).textTheme.caption,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                FavBtn(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
