import 'package:flutter/material.dart';
import 'package:flutter_initial_project/data/repositories/product_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products Page')),
      body: Center(
        child: ref
            .watch(productsProvider)
            .when(
              data: (products) => ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.title),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  );
                },
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(reloadProvider),
        tooltip: 'Reload Products',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
