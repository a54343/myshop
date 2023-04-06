class Order {
  String receiverAddress;
  double totalAmount;
  String orderno;
  String receiverPhone;
  String receiverName;
  List<Product> productList;
  int status;

  Order({
    required this.receiverAddress,
    required this.totalAmount,
    required this.orderno,
    required this.receiverPhone,
    required this.receiverName,
    required this.productList,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var productList = json['productList'] as List;
    List<Product> products =
        productList.map((product) => Product.fromJson(product)).toList();

    return Order(
      receiverAddress: json['receiverAddress'],
      totalAmount: json['totalAmount'].toDouble(),
      orderno: json['orderno'],
      receiverPhone: json['receiverPhone'],
      receiverName: json['receiverName'],
      productList: products,
      status: json['status'],
    );
  }
}

class Product {
  int productid;
  double price;
  String name;

  Product({
    required this.productid,
    required this.price,
    required this.name,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productid: json['productid'],
      price: json['price'].toDouble(),
      name: json['name'],
    );
  }
}
