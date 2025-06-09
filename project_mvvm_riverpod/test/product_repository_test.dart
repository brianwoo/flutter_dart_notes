import 'package:flutter_initial_project/data/models/products.dart';
import 'package:flutter_initial_project/data/services/product_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  // test provider
  test('test fetch products', () {
    final container = ProviderContainer(
      overrides: [
        fetchProductsProvider.overrideWith(
          (ref) => Future.value(
            FetchedProducts(
              products: [
                Product(
                  id: 1,
                  title: 'Test Product',
                  description: 'This is a test product',
                  price: 99.99,
                  availabilityStatus: AvailabilityStatus.IN_STOCK,
                  category: Category.FURNITURE,
                  discountPercentage: 2.3,
                  rating: 2.1,
                  stock: 76,
                  tags: [],
                  sku: "JJD-ESE",
                  weight: 3,
                  dimensions: Dimensions(
                    width: 15.14,
                    height: 13.08,
                    depth: 22.99,
                  ),
                  warrantyInformation: '1 week warranty',
                  shippingInformation: 'Ships in 3-5 business days',
                  reviews: [],
                  returnPolicy: ReturnPolicy.NO_RETURN_POLICY,
                  minimumOrderQuantity: 1,
                  meta: Meta(
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                    barcode: "1234567890",
                    qrCode: "0987654321",
                  ),
                  images: [],
                  thumbnail: '',
                ),
              ],
              limit: 1,
              skip: 0,
              total: 99,
            ),
          ), // Mocked response
        ),
      ],
    );

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
          1,
        ),
      ),
    );

    expect(
      subscription.read(),
      completion(
        isA<FetchedProducts>().having(
          (p) => p.products[0].title,
          'title',
          'Test Product',
        ),
      ),
    );
  });
}
