import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/features/listings/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_static_routes.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_star_rating_widget.dart';

class ListingCard extends StatefulWidget {
  final Product product;
  final bool isLiked;
  final VoidCallback? onLikeToggle;

  const ListingCard({
    Key? key,
    required this.product,
    required this.isLiked,
    this.onLikeToggle,
  }) : super(key: key);

  @override
  State<ListingCard> createState() => _ListingCardState();
}

class _ListingCardState extends State<ListingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onLikePressed() {
    if (widget.onLikeToggle != null) {
      _animationController.forward().then((_) {
        _animationController.reverse();
      });

      widget.onLikeToggle!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: widget.product.thumbnail,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.product.title, style: AppTextStyles.captionDark),
            Text(
              'Category: ${widget.product.category}',
              style: AppTextStyles.microDark,
            ),
            SizedBox(height: 3),
            AppStarRatingWidget(rating: widget.product.rating),
            SizedBox(height: 20),
            Row(
              spacing: 10,
              children: [
                Text(
                  '${widget.product.price.toStringAsFixed(2)}\$',
                  style: AppTextStyles.captionPrimary,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.product.availabilityStatus == 'In Stock'
                        ? Colors.green
                        : Colors.orange,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.product.availabilityStatus,
                    style: AppTextStyles.micro.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: GestureDetector(
          onTap: _onLikePressed,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    child: Icon(
                      widget.isLiked ? Icons.favorite : Icons.favorite,
                      color: widget.isLiked ? Colors.red : Colors.grey,
                      size: 28,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        onTap: () {
          context.pushNamed(
            AppStaticRoutes.productDetail,
            pathParameters: {'productId': '${widget.product.id}'},
          );
        },
      ),
    );
  }
}
