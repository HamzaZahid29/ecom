class Product {
  final int id;
  final String title;
  final double price;
  final String category;
  final String availabilityStatus;
  final double rating;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.availabilityStatus,
    required this.rating,
    required this.thumbnail,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      category: map['category'] ?? '',
      availabilityStatus: map['availabilityStatus'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      thumbnail: map['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'category': category,
      'availabilityStatus': availabilityStatus,
      'rating': rating,
      'thumbnail': thumbnail,
    };
  }
}

class ProductListResponse {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  ProductListResponse({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductListResponse.fromMap(Map<String, dynamic> map) {
    return ProductListResponse(
      products: List<Product>.from(
        map['products']?.map((x) => Product.fromMap(x)) ?? [],
      ),
      total: map['total'] ?? 0,
      skip: map['skip'] ?? 0,
      limit: map['limit'] ?? 0,
    );
  }
}
