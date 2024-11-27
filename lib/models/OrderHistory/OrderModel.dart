class OrderModel {
  final int id;
  final String customerName;
  final int billId;
  final String orderDate;
  final String deliveryData;
  final int amount;
  final String note;
  final List<String> tag;
  final String orderStatus;
  final String imgUrl;
  final String restaurantName;
  final String address;
  final int user;
  final int restaurant;

  OrderModel({
    required this.id,
    required this.customerName,
    required this.billId,
    required this.orderDate,
    required this.deliveryData,
    required this.amount,
    required this.note,
    required this.tag,
    required this.orderStatus,
    required this.imgUrl,
    required this.restaurantName,
    required this.address,
    required this.user,
    required this.restaurant,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int,
      customerName: json['customer_name'] as String,
      billId: json['bill_id'] as int,
      orderDate: json['order_date'] as String,
      deliveryData: json['delivery_data'] as String,
      amount: json['amount'] as int,
      note: json['note'] as String,
      tag: List<String>.from(json['tag'] as List),
      orderStatus: json['order_status'] as String,
      imgUrl: json["image"] as String? ?? "",
      restaurantName: json["resturant_name"] as String? ?? "",
      address: json['address'] as String? ?? "",
      user: json['user'] as int,
      restaurant: json['resturant'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_name': customerName,
      'bill_id': billId,
      'order_date': orderDate,
      'delivery_data': deliveryData,
      'amount': amount,
      'note': note,
      'tag': tag,
      'order_status': orderStatus,
      'img_url': imgUrl,
      'restaurant_name': restaurantName,
      'address': address,
      'user': user,
      'resturant': restaurant,
    };
  }
  OrderModel copyWith({
    int? id,
    String? customerName,
    int? billId,
    String? orderDate,
    String? deliveryData,
    int? amount,
    String? note,
    List<String>? tag,
    String? orderStatus,
    String? imgUrl,
    String? restaurantName,
    String? address,
    int? user,
    int? restaurant,
  }) {
    return OrderModel(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      billId: billId ?? this.billId,
      orderDate: orderDate ?? this.orderDate,
      deliveryData: deliveryData ?? this.deliveryData,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      tag: tag ?? this.tag,
      orderStatus: orderStatus ?? this.orderStatus,
      imgUrl: imgUrl ?? this.imgUrl,
      restaurantName: restaurantName ?? this.restaurantName,
      address: address ?? this.address,
      user: user ?? this.user,
      restaurant: restaurant ?? this.restaurant,
    );
  }
}
