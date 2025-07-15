import 'package:ecom/features/details/models/product_detail_mode.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_star_rating_widget.dart';

class ReviewRow extends StatelessWidget {
  ProductDetail product;
  ReviewRow({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppStarRatingWidget(rating: product.rating),
        const SizedBox(width: 8),
        Text(
            '${product.rating} (${product.reviews.length} reviews)',
            style: AppTextStyles.caption
        ),
      ],
    );
  }
}
