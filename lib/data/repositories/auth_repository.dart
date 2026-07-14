import 'package:dentalflow/core/services/supabase_service.dart';
import 'package:dentalflow/data/models/user_model.dart';

class AuthRepository {
  static final AuthRepository _instance = AuthRepository._internal();

  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._internal();

  Future<UserModel?> login(String username, String password) async {
    try {
      final response = await SupabaseService.table('users')
          .select()
          .eq('username', username)
          .single();

      if (response != null) {
        // TODO: Verify password securely (should use hashed passwords)
        return UserModel.fromJson(response);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await SupabaseService.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final session = SupabaseService.auth.currentSession;
      if (session == null) return null;

      final response = await SupabaseService.table('users')
          .select()
          .eq('id', session.user.id)
          .single();

      return UserModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await SupabaseService.auth.resetPasswordForEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> createUser(UserModel user, String password) async {
    try {
      final response =
          await SupabaseService.table('users').insert(user.toJson()).select();
      return response.first['id'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(String userId, UserModel user) async {
    try {
      await SupabaseService.table('users')
          .update(user.toJson())
          .eq('id', userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await SupabaseService.table('users').delete().eq('id', userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> activateUser(String userId) async {
    try {
      await SupabaseService.table('users')
          .update({'status': 'active'}).eq('id', userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deactivateUser(String userId) async {
    try {
      await SupabaseService.table('users')
          .update({'status': 'inactive'}).eq('id', userId);
    } catch (e) {
      rethrow;
    }
  }
}
