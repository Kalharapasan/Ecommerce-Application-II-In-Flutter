import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ecom_ii/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: 'https://ubjcijjbvujtyqfizbty.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InViamNpampidnVqdHlxZml6YnR5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njk4ODQwNzQsImV4cCI6MjA4NTQ2MDA3NH0.obbMbf6wacQJuAT-guoV_EM292g8sY7dRDYxc3zdjzA',
  );
  
  runApp(App());
}
