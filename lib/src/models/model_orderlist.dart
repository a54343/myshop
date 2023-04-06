class Orderlist {
  final int id;
  final int userId;
  final String orderNo;
  final double totalAmount;
  final double actualAmount;
  final int status;
  final DateTime createdTime;
  final DateTime updatedTime;
  final String receiverName;
  final String receiverPhone;
  final String receiverAddress;
  final String? remark;
  final String? paymentMethod;
  final DateTime? paymentTime;
  final DateTime? deliveryTime;
  final DateTime? receiveTime;

  Orderlist({
    required this.id,
    required this.userId,
    required this.orderNo,
    required this.totalAmount,
    required this.actualAmount,
    required this.status,
    required this.createdTime,
    required this.updatedTime,
    required this.receiverName,
    required this.receiverPhone,
    required this.receiverAddress,
    this.remark,
    this.paymentMethod,
    this.paymentTime,
    this.deliveryTime,
    this.receiveTime,
  });

  factory Orderlist.fromJson(Map<String, dynamic> json) {
    return Orderlist(
      id: json['id'] as int,
      userId: json['userId'] as int,
      orderNo: json['orderNo'] as String,
      totalAmount: json['totalAmount'] as double,
      actualAmount: json['actualAmount'] as double,
      status: json['status'] as int,
      createdTime: DateTime.parse(json['createdTime'] as String),
      updatedTime: DateTime.parse(json['updatedTime'] as String),
      receiverName: json['receiverName'] as String,
      receiverPhone: json['receiverPhone'] as String,
      receiverAddress: json['receiverAddress'] as String,
      remark: json['remark'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      paymentTime: json['paymentTime'] != null
          ? DateTime.parse(json['paymentTime'] as String)
          : null,
      deliveryTime: json['deliveryTime'] != null
          ? DateTime.parse(json['deliveryTime'] as String)
          : null,
      receiveTime: json['receiveTime'] != null
          ? DateTime.parse(json['receiveTime'] as String)
          : null,
    );
  }
}
