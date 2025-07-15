import 'package:ecom/core/providers/app_base_provider.dart';
import '../../../core/network/api_result.dart';
import '../models/product_detail_mode.dart';
import '../repository/product_detail_repository.dart';

class ProductDetailProvider extends ApiBaseProvider {
  final String productId;

  ProductDetailProvider({required this.productId}) {
    getProductDetail();
  }

  ProductDetailRepository _productDetailRepository = ProductDetailRepository.instance;
  ProductDetail? product;

  Future<void> getProductDetail() async {
    setError(false);
    setLoading(true);

    try {
      final result = await _productDetailRepository.getProductDetail(productId);

      if (result is Success) {
        product = ProductDetail.fromMap(result.data);
        notifyListeners();
      } else {
        setError(true);
      }
    } catch (e) {
      print('Error fetching product detail: ${e.toString()}');
      setError(true);
    } finally {
      setLoading(false);
    }
  }

  Future<void> refresh() async {
    await getProductDetail();
  }
}