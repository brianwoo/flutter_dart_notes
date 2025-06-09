import 'package:flutter_initial_project/data/services/product_service.dart';
import 'package:flutter_initial_project/domain/models/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_repository.g.dart';

@riverpod
Future<List<Product>> products(Ref ref) async {
  final fetchedProducts = await ref.watch(fetchProductsProvider.future);

  final products = fetchedProducts.products.map((product) {
    return Product(
      id: product.id,
      title: product.title,
      description: product.description,
      price: product.price,
      availabilityStatus: AvailabilityStatus.values.byName(
        product.availabilityStatus.name,
      ),
      category: Category.values.byName(product.category.name),
    );
  }).toList();

  return products;
}

@riverpod
void reload(Ref ref) {
  ref.invalidate(fetchProductsProvider);
}
