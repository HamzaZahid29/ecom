import 'package:ecom/core/providers/app_base_provider.dart';
import 'package:ecom/features/listings/models/product_model.dart'; // Add this import
import 'package:ecom/features/listings/repository/listing_repository.dart';

import '../../../core/network/api_result.dart';

class ListingProvider extends ApiBaseProvider {
  ListingProvider() {
    getAllListing(); // Initialize data on provider creation
  }

  ListingRepository _listingRepository = ListingRepository.instance;

  List<Product> products = [];
  ProductListResponse? productListResponse;
  bool isLoadingMore = false;
  bool hasMoreData = true;
  int currentPage = 0;
  final int pageSize = 10;

  Future<void> getAllListing({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 0;
      hasMoreData = true;
      products.clear();
    }

    setError(false);
    setLoading(true);
    try {
      final result = await _listingRepository.getProducts(
        limit: pageSize,
        skip: currentPage * pageSize,
      );
      if (result is Success) {
        productListResponse = ProductListResponse.fromMap(result.data);
        if (isRefresh) {
          products = productListResponse?.products ?? [];
        } else {
          products.addAll(productListResponse?.products ?? []);
        }

        // Check if there's more data
        hasMoreData = products.length < (productListResponse?.total ?? 0);
        currentPage++;

        notifyListeners(); // Notify UI about the update
      } else {
        setError(true);
      }
    } catch (e) {
      print(e.toString());
      setError(true);
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore || !hasMoreData) return;

    isLoadingMore = true;
    notifyListeners();

    try {
      final result = await _listingRepository.getProducts(
        limit: pageSize,
        skip: currentPage * pageSize,
      );
      if (result is Success) {
        final response = ProductListResponse.fromMap(result.data);
        products.addAll(response.products);

        // Check if there's more data
        hasMoreData = products.length < (response.total);
        currentPage++;

        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoadingMore = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await getAllListing(isRefresh: true);
  }
}
