import 'package:soping/src/models/product_model.dart';

class CartItem {
  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
  });

  final int id;
  final ProductModel product;
  int quantity;

  double get totalPrice => quantity * product.price;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}
