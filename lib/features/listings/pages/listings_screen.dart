import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/core/router/app_static_routes.dart';
import 'package:ecom/core/theme/app_text_styles.dart';
import 'package:ecom/core/widgets/app_star_rating_widget.dart';
import 'package:ecom/features/favourites/providers/favourites_provider.dart';
import 'package:ecom/features/listings/widgets/listing_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

import '../provider/listing_screen_provider.dart';

class ListingsScreen extends StatefulWidget {
  @override
  _ListingsScreenState createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      final provider = Provider.of<ListingProvider>(context, listen: false);
      if (provider.hasMoreData && !provider.isLoadingMore) {
        provider.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        leading: IconButton(onPressed: (){
            context.pushNamed(AppStaticRoutes.favouritesScreen);
        }, icon: Icon(Icons.favorite_border)),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(AppStaticRoutes.profileScreen);
            },
            icon: Icon(HugeIcons.strokeRoundedUser),
          ),
        ],
      ),
      body: Consumer2<ListingProvider, FavouritesProvider>(
        builder: (context, listingProvider, favouritesProvider, child) {
          if (listingProvider.isLoading && listingProvider.products.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          if (listingProvider.isError && listingProvider.products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error loading products'),
                  ElevatedButton(
                    onPressed: () => listingProvider.refresh(),
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (listingProvider.products.isEmpty) {
            return Center(child: Text('No products found'));
          }

          return RefreshIndicator(
            onRefresh: () => listingProvider.refresh(),
            child: ListView.builder(
              controller: _scrollController,
              itemCount:
                  listingProvider.products.length +
                  (listingProvider.hasMoreData ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == listingProvider.products.length) {
                  return Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: listingProvider.isLoadingMore
                          ? CircularProgressIndicator()
                          : SizedBox.shrink(),
                    ),
                  );
                }

                final product = listingProvider.products[index];
                return ListingCard(
                  product: product,
                  onTap: () {
                  },
                  onLikeToggle: (){
                    favouritesProvider.likeProduct(product);

                  },
                  isLiked: favouritesProvider.isLiked(product),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
