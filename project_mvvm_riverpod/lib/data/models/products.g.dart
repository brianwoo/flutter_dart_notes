// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FetchedProducts _$FetchedProductsFromJson(Map<String, dynamic> json) =>
    _FetchedProducts(
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      skip: (json['skip'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
    );

Map<String, dynamic> _$FetchedProductsToJson(_FetchedProducts instance) =>
    <String, dynamic>{
      'products': instance.products,
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
    };

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  category: $enumDecode(_$CategoryEnumMap, json['category']),
  price: (json['price'] as num).toDouble(),
  discountPercentage: (json['discountPercentage'] as num).toDouble(),
  rating: (json['rating'] as num).toDouble(),
  stock: (json['stock'] as num).toInt(),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  brand: json['brand'] as String?,
  sku: json['sku'] as String,
  weight: (json['weight'] as num).toInt(),
  dimensions: Dimensions.fromJson(json['dimensions'] as Map<String, dynamic>),
  warrantyInformation: json['warrantyInformation'] as String,
  shippingInformation: json['shippingInformation'] as String,
  availabilityStatus: $enumDecode(
    _$AvailabilityStatusEnumMap,
    json['availabilityStatus'],
  ),
  reviews: (json['reviews'] as List<dynamic>)
      .map((e) => Review.fromJson(e as Map<String, dynamic>))
      .toList(),
  returnPolicy: $enumDecode(_$ReturnPolicyEnumMap, json['returnPolicy']),
  minimumOrderQuantity: (json['minimumOrderQuantity'] as num).toInt(),
  meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  thumbnail: json['thumbnail'] as String,
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'category': _$CategoryEnumMap[instance.category]!,
  'price': instance.price,
  'discountPercentage': instance.discountPercentage,
  'rating': instance.rating,
  'stock': instance.stock,
  'tags': instance.tags,
  'brand': instance.brand,
  'sku': instance.sku,
  'weight': instance.weight,
  'dimensions': instance.dimensions,
  'warrantyInformation': instance.warrantyInformation,
  'shippingInformation': instance.shippingInformation,
  'availabilityStatus':
      _$AvailabilityStatusEnumMap[instance.availabilityStatus]!,
  'reviews': instance.reviews,
  'returnPolicy': _$ReturnPolicyEnumMap[instance.returnPolicy]!,
  'minimumOrderQuantity': instance.minimumOrderQuantity,
  'meta': instance.meta,
  'images': instance.images,
  'thumbnail': instance.thumbnail,
};

const _$CategoryEnumMap = {
  Category.BEAUTY: 'beauty',
  Category.FRAGRANCES: 'fragrances',
  Category.FURNITURE: 'furniture',
  Category.GROCERIES: 'groceries',
};

const _$AvailabilityStatusEnumMap = {
  AvailabilityStatus.IN_STOCK: 'In Stock',
  AvailabilityStatus.LOW_STOCK: 'Low Stock',
};

const _$ReturnPolicyEnumMap = {
  ReturnPolicy.NO_RETURN_POLICY: 'No return policy',
  ReturnPolicy.THE_30_DAYS_RETURN_POLICY: '30 days return policy',
  ReturnPolicy.THE_60_DAYS_RETURN_POLICY: '60 days return policy',
  ReturnPolicy.THE_7_DAYS_RETURN_POLICY: '7 days return policy',
  ReturnPolicy.THE_90_DAYS_RETURN_POLICY: '90 days return policy',
};

_Dimensions _$DimensionsFromJson(Map<String, dynamic> json) => _Dimensions(
  width: (json['width'] as num).toDouble(),
  height: (json['height'] as num).toDouble(),
  depth: (json['depth'] as num).toDouble(),
);

Map<String, dynamic> _$DimensionsToJson(_Dimensions instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'depth': instance.depth,
    };

_Meta _$MetaFromJson(Map<String, dynamic> json) => _Meta(
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  barcode: json['barcode'] as String,
  qrCode: json['qrCode'] as String,
);

Map<String, dynamic> _$MetaToJson(_Meta instance) => <String, dynamic>{
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'barcode': instance.barcode,
  'qrCode': instance.qrCode,
};

_Review _$ReviewFromJson(Map<String, dynamic> json) => _Review(
  rating: (json['rating'] as num).toInt(),
  comment: json['comment'] as String,
  date: DateTime.parse(json['date'] as String),
  reviewerName: json['reviewerName'] as String,
  reviewerEmail: json['reviewerEmail'] as String,
);

Map<String, dynamic> _$ReviewToJson(_Review instance) => <String, dynamic>{
  'rating': instance.rating,
  'comment': instance.comment,
  'date': instance.date.toIso8601String(),
  'reviewerName': instance.reviewerName,
  'reviewerEmail': instance.reviewerEmail,
};
