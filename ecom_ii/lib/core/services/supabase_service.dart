import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ecom_ii/core/models/product.dart';
import 'package:ecom_ii/core/models/user.dart' as app_user;

class SupabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;
  Future<app_user.User?> getCurrentUser() async {
    final session = _supabase.auth.currentSession;
    if (session == null) return null;

    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', session.user.id)
        .single();

    return app_user.User.fromJson(response);
  }

  Future<List<Product>> getProducts({
    String? category,
    bool? featured,
    int limit = 20,
    int offset = 0,
  }) async {
    var query = _supabase.from('products').select();
    
    if (category != null && category != 'All') {
      query = query.eq('category', category);
    }
    
    if (featured != null) {
      query = query.eq('is_featured', featured);
    }
    
    final response = await query
        .order('created_at', ascending: false)
        .range(offset, offset + limit - 1);
    return (response as List).map((json) => Product.fromJson(json)).toList();
  }

  Future<Product> getProduct(String id) async {
    final response = await _supabase
        .from('products')
        .select()
        .eq('id', id)
        .single();
    
    return Product.fromJson(response);
  }

  Future<void> createOrder({
    required String userId,
    required List<Map<String, dynamic>> items,
    required double totalAmount,
    required String shippingAddress,
    required String paymentMethod,
  }) async {
    await _supabase.from('orders').insert({
      'user_id': userId,
      'items': items,
      'total_amount': totalAmount,
      'shipping_address': shippingAddress,
      'payment_method': paymentMethod,
      'status': 'pending',
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getOrders(String userId) async {
    final response = await _supabase
        .from('orders')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    
    return List<Map<String, dynamic>>.from(response);
  }


}