import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'products.freezed.dart';
part 'products.g.dart';

@freezed
abstract class FetchedProducts with _$FetchedProducts {
  const factory FetchedProducts({
    @JsonKey(name: "products") required List<Product> products,
    @JsonKey(name: "total") required int total,
    @JsonKey(name: "skip") required int skip,
    @JsonKey(name: "limit") required int limit,
  }) = _FetchedProducts;

  factory FetchedProducts.fromJson(Map<String, dynamic> json) =>
      _$FetchedProductsFromJson(json);
}

@freezed
abstract class Product with _$Product {
  const factory Product({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "description") required String description,
    @JsonKey(name: "category") required Category category,
    @JsonKey(name: "price") required double price,
    @JsonKey(name: "discountPercentage") required double discountPercentage,
    @JsonKey(name: "rating") required double rating,
    @JsonKey(name: "stock") required int stock,
    @JsonKey(name: "tags") required List<String> tags,
    @JsonKey(name: "brand") String? brand,
    @JsonKey(name: "sku") required String sku,
    @JsonKey(name: "weight") required int weight,
    @JsonKey(name: "dimensions") required Dimensions dimensions,
    @JsonKey(name: "warrantyInformation") required String warrantyInformation,
    @JsonKey(name: "shippingInformation") required String shippingInformation,
    @JsonKey(name: "availabilityStatus")
    required AvailabilityStatus availabilityStatus,
    @JsonKey(name: "reviews") required List<Review> reviews,
    @JsonKey(name: "returnPolicy") required ReturnPolicy returnPolicy,
    @JsonKey(name: "minimumOrderQuantity") required int minimumOrderQuantity,
    @JsonKey(name: "meta") required Meta meta,
    @JsonKey(name: "images") required List<String> images,
    @JsonKey(name: "thumbnail") required String thumbnail,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

enum AvailabilityStatus {
  @JsonValue("In Stock")
  IN_STOCK,
  @JsonValue("Low Stock")
  LOW_STOCK,
}

final availabilityStatusValues = EnumValues({
  "In Stock": AvailabilityStatus.IN_STOCK,
  "Low Stock": AvailabilityStatus.LOW_STOCK,
});

enum Category {
  @JsonValue("beauty")
  BEAUTY,
  @JsonValue("fragrances")
  FRAGRANCES,
  @JsonValue("furniture")
  FURNITURE,
  @JsonValue("groceries")
  GROCERIES,
}

final categoryValues = EnumValues({
  "beauty": Category.BEAUTY,
  "fragrances": Category.FRAGRANCES,
  "furniture": Category.FURNITURE,
  "groceries": Category.GROCERIES,
});

@freezed
abstract class Dimensions with _$Dimensions {
  const factory Dimensions({
    @JsonKey(name: "width") required double width,
    @JsonKey(name: "height") required double height,
    @JsonKey(name: "depth") required double depth,
  }) = _Dimensions;

  factory Dimensions.fromJson(Map<String, dynamic> json) =>
      _$DimensionsFromJson(json);
}

@freezed
abstract class Meta with _$Meta {
  const factory Meta({
    @JsonKey(name: "createdAt") required DateTime createdAt,
    @JsonKey(name: "updatedAt") required DateTime updatedAt,
    @JsonKey(name: "barcode") required String barcode,
    @JsonKey(name: "qrCode") required String qrCode,
  }) = _Meta;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

enum ReturnPolicy {
  @JsonValue("No return policy")
  NO_RETURN_POLICY,
  @JsonValue("30 days return policy")
  THE_30_DAYS_RETURN_POLICY,
  @JsonValue("60 days return policy")
  THE_60_DAYS_RETURN_POLICY,
  @JsonValue("7 days return policy")
  THE_7_DAYS_RETURN_POLICY,
  @JsonValue("90 days return policy")
  THE_90_DAYS_RETURN_POLICY,
}

final returnPolicyValues = EnumValues({
  "No return policy": ReturnPolicy.NO_RETURN_POLICY,
  "30 days return policy": ReturnPolicy.THE_30_DAYS_RETURN_POLICY,
  "60 days return policy": ReturnPolicy.THE_60_DAYS_RETURN_POLICY,
  "7 days return policy": ReturnPolicy.THE_7_DAYS_RETURN_POLICY,
  "90 days return policy": ReturnPolicy.THE_90_DAYS_RETURN_POLICY,
});

@freezed
abstract class Review with _$Review {
  const factory Review({
    @JsonKey(name: "rating") required int rating,
    @JsonKey(name: "comment") required String comment,
    @JsonKey(name: "date") required DateTime date,
    @JsonKey(name: "reviewerName") required String reviewerName,
    @JsonKey(name: "reviewerEmail") required String reviewerEmail,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
