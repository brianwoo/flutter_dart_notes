import 'package:flutter_initial_project/data/models/products.dart';
import 'package:flutter_initial_project/data/services/product_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  // test provider
  test('test fetch products', () {
    final container = ProviderContainer();

    final subscription = container.listen<Future<FetchedProducts>>(
      fetchProductsProvider.future,
      (_, __) {},
    );

    expect(
      subscription.read(),
      completion(
        isA<FetchedProducts>().having(
          (p) => p.products.length,
          'products length',
          greaterThan(0),
        ),
      ),
    );
  });
}
