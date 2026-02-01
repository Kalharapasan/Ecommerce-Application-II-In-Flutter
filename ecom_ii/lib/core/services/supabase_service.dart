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


}