import 'package:ecom/features/details/models/product_detail_mode.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/theme/app_text_styles.dart';

class ProductDetailsSection extends StatelessWidget {
  ProductDetail product;

  ProductDetailsSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product details
        Text('Product Details', style: AppTextStyles.heading3),
        const SizedBox(height: 12),
        _buildDetailRow('SKU', product.sku),
        _buildDetailRow('Weight', '${product.weight} oz'),
        _buildDetailRow(
          'Dimensions',
          '${product.dimensions.width} × ${product.dimensions.height} × ${product.dimensions.depth} cm',
        ),
        _buildDetailRow('Warranty', product.warrantyInformation),
        _buildDetailRow('Shipping', product.shippingInformation),
        _buildDetailRow('Return Policy', product.returnPolicy),
        _buildDetailRow(
          'Min Order Quantity',
          '${product.minimumOrderQuantity} units',
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text('$label:', style: AppTextStyles.caption),
          ),
          Expanded(child: Text(value, style: AppTextStyles.captionDark)),
        ],
      ),
    );
  }
}
