import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/features/listings/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_star_rating_widget.dart';

class ListingCard extends StatelessWidget {
  Product product;
  VoidCallback onTap;
  bool isLiked;
  ListingCard({super.key, required this.product, required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl:  product.thumbnail,
          width: 60,
          height: 60,
          fit: BoxFit.cover,

        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.title, style: AppTextStyles.captionDark),
            Text(
              'Category: ${product.category}',
              style: AppTextStyles.microDark,
            ),
            SizedBox(height: 3,),
            AppStarRatingWidget(rating: product.rating),
            SizedBox(height: 20),
            Row(
              spacing: 10,
              children: [
                Text(
                  '${product.price.toStringAsFixed(2)}\$',
                  style: AppTextStyles.captionPrimary,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: product.availabilityStatus == 'In Stock'
                        ? Colors.green
                        : Colors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    product.availabilityStatus,
                    style: AppTextStyles.micro.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(onPressed: (){}, icon: Icon(HugeIcons.strokeRoundedFavourite)),
      ),
    );
  }
}
