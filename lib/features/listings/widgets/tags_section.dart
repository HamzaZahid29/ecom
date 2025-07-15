import 'package:ecom/features/details/models/product_detail_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';

class TagsSection extends StatelessWidget {
  ProductDetail product;
   TagsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tags',
          style: AppTextStyles.heading3,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          children: product.tags.map((tag) {
            return Chip(
              label: Text(tag),
              backgroundColor: Colors.blue[100],
            );
          }).toList(),
        ),
      ],
    );
  }
}
