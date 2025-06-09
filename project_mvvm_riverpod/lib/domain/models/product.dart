enum AvailabilityStatus { IN_STOCK, LOW_STOCK }

enum Category { BEAUTY, FRAGRANCES, FURNITURE, GROCERIES }

class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final AvailabilityStatus availabilityStatus;
  final Category category;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.availabilityStatus,
    required this.category,
  });
}
