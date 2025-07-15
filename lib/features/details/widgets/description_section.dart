import 'package:ecom/features/details/models/product_detail_mode.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/theme/app_text_styles.dart';

class DescriptionSection extends StatelessWidget {
  ProductDetail product;

  DescriptionSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: AppTextStyles.heading3),
        const SizedBox(height: 8),
        Text(product.description, style: AppTextStyles.captionDark),
      ],
    );
  }
}
