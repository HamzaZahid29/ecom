import 'package:ecom/features/details/widgets/description_section.dart';
import 'package:ecom/features/details/widgets/product_base_info_section.dart';
import 'package:ecom/features/details/widgets/product_details_section.dart';
import 'package:ecom/features/details/widgets/reviews_section.dart';
import 'package:ecom/features/listings/widgets/tags_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_detail_mode.dart';
import '../providers/product_detail_provider.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductDetailProvider(productId: productId),
      child: Consumer<ProductDetailProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (provider.isError || provider.product == null) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Failed to load product details',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => provider.refresh(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          final product = provider.product!;
          return _buildProductDetail(context, product);
        },
      ),
    );
  }

  Widget _buildProductDetail(BuildContext context, ProductDetail product) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with product image
          SliverAppBar(
            expandedHeight: 400.0,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: PageView.builder(
                itemCount: product.images.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    product.images[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported, size: 100),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductBaseInfoSection(product: product),
                  const SizedBox(height: 24),
                  DescriptionSection(product: product),
                  const SizedBox(height: 24),
                  ProductDetailsSection(product: product),
                  const SizedBox(height: 24),
                  TagsSection(product: product),
                  const SizedBox(height: 24),
                  ReviewsSection(product: product),
                  const SizedBox(height: 100), // Space for bottom buttons
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
