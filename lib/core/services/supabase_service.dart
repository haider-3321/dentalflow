import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  // Update with your Supabase credentials
  static const String supabaseUrl = 'https://your-project-url.supabase.co';
  static const String supabaseAnonKey = 'your-anon-key';

  static late Supabase _instance;

  static Future<void> initialize() async {
    try {
      _instance = await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
      );
    } catch (e) {
      throw Exception('Failed to initialize Supabase: $e');
    }
  }

  static Supabase get instance => _instance;

  static SupabaseClient get client => _instance.client;

  static GotrueClient get auth => client.auth;

  static SupabaseQueryBuilder table(String table) => client.from(table);

  static bool isAuthenticated() {
    return auth.currentSession != null;
  }

  static String? getCurrentUserId() {
    return auth.currentSession?.user.id;
  }
}
