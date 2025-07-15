import 'package:ecom/features/favourites/providers/favourites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../listings/widgets/listing_card.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favourites')),
      body: Consumer<FavouritesProvider>(
        builder: (context, provider, child) {
          return (provider.favouritesProductsList.length == 0)
              ? Center(child: Text('No Favourites'))
              : ListView.builder(
                  itemCount: provider.favouritesProductsList.length,
                  itemBuilder: (context, index) {
                    final product = provider.favouritesProductsList[index];
                    return ListingCard(
                      product: product,
                      onLikeToggle: () {
                        provider.likeProduct(product);
                      },
                      isLiked: provider.isLiked(product),
                    );
                  },
                );
        },
      ),
    );
  }
}
