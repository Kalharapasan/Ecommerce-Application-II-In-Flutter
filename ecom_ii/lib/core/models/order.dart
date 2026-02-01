class Order {
  final String id;
  final String orderNumber;
  final String userId;
  final double subtotal;
  final double taxAmount;
  final double shippingAmount;
  final double discountAmount;
  final double totalAmount;
  final String status;
  final String paymentStatus;
  final String? shippingAddress;
  final DateTime createdAt;

  Order({
    required this.id,
    required this.orderNumber,
    required this.userId,
    required this.subtotal,
    this.taxAmount = 0,
    this.shippingAmount = 0,
    this.discountAmount = 0,
    required this.totalAmount,
    required this.status,
    required this.paymentStatus,
    this.shippingAddress,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      orderNumber: json['order_number'] ?? '',
      userId: json['user_id'] ?? '',
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      taxAmount: (json['tax_amount'] ?? 0).toDouble(),
      shippingAmount: (json['shipping_amount'] ?? 0).toDouble(),
      discountAmount: (json['discount_amount'] ?? 0).toDouble(),
      totalAmount: (json['total_amount'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      paymentStatus: json['payment_status'] ?? 'pending',
      shippingAddress: json['shipping_address'],
      createdAt: DateTime.parse(
        json['created_at'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_number': orderNumber,
      'user_id': userId,
      'subtotal': subtotal,
      'tax_amount': taxAmount,
      'shipping_amount': shippingAmount,
      'discount_amount': discountAmount,
      'total_amount': totalAmount,
      'status': status,
      'payment_status': paymentStatus,
      'shipping_address': shippingAddress,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
