import 'package:dio/dio.dart';
import 'package:flutter_initial_project/data/models/products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_service.g.dart';

final dio = Dio();

@riverpod
Future<FetchedProducts> fetchProducts(Ref ref) async {
  try {
    final response = await dio.get('https://dummyjson.com/products');
    if (response.statusCode == 200) {
      return FetchedProducts.fromJson(response.data);
    } else {
      throw Exception('Failed to load products');
    }
  } catch (e) {
    throw Exception('Failed to load products: $e');
  }
}
