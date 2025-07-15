import 'package:ecom/core/services/app_log_service.dart';
import 'package:ecom/features/listings/models/product_model.dart';
import 'package:flutter/material.dart';

class FavouritesProvider extends ChangeNotifier {
  List<Product> favouritesProductsList = [];

  void likeProduct(Product product) {
    LogService.debug(product.title);
    LogService.debug(favouritesProductsList.length.toString());
    if (favouritesProductsList.contains(product)) {
      favouritesProductsList.remove(product);
    } else {
      favouritesProductsList.add(product);
    }
    notifyListeners();
  }

  bool isLiked(Product product) {
    if (favouritesProductsList.contains(product)) {
      return true;
    } else {
      return false;
    }
  }
}
