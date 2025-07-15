import 'package:ecom/features/details/models/product_detail_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_star_rating_widget.dart';

class ReviewsSection extends StatelessWidget {
  ProductDetail product;
   ReviewsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews',
          style: AppTextStyles.heading3,
        ),
        const SizedBox(height: 12),
        ...product.reviews.map((review) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                        review.reviewerName,
                        style: AppTextStyles.captionDark
                    ),
                    const Spacer(),
                    AppStarRatingWidget(rating: review.rating.toDouble()),

                  ],
                ),
                const SizedBox(height: 8),
                Text(review.comment, style: AppTextStyles.captionDark,),
                const SizedBox(height: 8),
                Text(
                    DateTime.parse(review.date).toString().split(' ')[0],
                    style: AppTextStyles.microPrimary
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
