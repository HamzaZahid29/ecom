import 'package:ecom/features/details/models/product_detail_mode.dart';
import 'package:ecom/features/details/widgets/review_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_theme.dart';

class ProductBaseInfoSection extends StatelessWidget {
  ProductDetail product;
  ProductBaseInfoSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product title and brand
        Text(
          product.title,
          style: AppTextStyles.heading2,
        ),
        const SizedBox(height: 8),
        Text(
            'Brand: ${product.brand}',
            style: AppTextStyles.captionDark
        ),
        const SizedBox(height: 4),
        ReviewRow(product: product),

        const SizedBox(height: 10),

        // Price and discount
        Row(
          children: [
            Text(
              '\$${product.price}',
              style: AppTextStyles.heading2.copyWith(color: AppThemes.primaryColor),
            ),
            const SizedBox(width: 8),
            if (product.discountPercentage > 0)
              Text(
                '${product.discountPercentage}% OFF',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),

        // Stock status
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: product.stock > 10 ? Colors.green : Colors.orange,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            product.availabilityStatus,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
