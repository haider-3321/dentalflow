import 'package:dentalflow/core/services/supabase_service.dart';
import 'package:dentalflow/data/models/appointment_model.dart';

class AppointmentRepository {
  static final AppointmentRepository _instance = AppointmentRepository._internal();

  factory AppointmentRepository() {
    return _instance;
  }

  AppointmentRepository._internal();

  Future<List<AppointmentModel>> getAllAppointments() async {
    try {
      final response = await SupabaseService.table('appointments').select();
      return (response as List)
          .map((a) => AppointmentModel.fromJson(a))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AppointmentModel>> getAppointmentsByDoctor(String doctorId) async {
    try {
      final response = await SupabaseService.table('appointments')
          .select()
          .eq('doctor_id', doctorId);
      return (response as List)
          .map((a) => AppointmentModel.fromJson(a))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AppointmentModel>> getAppointmentsByPatient(String patientId) async {
    try {
      final response = await SupabaseService.table('appointments')
          .select()
          .eq('patient_id', patientId);
      return (response as List)
          .map((a) => AppointmentModel.fromJson(a))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AppointmentModel>> getTodayAppointments() async {
    try {
      final today = DateTime.now();
      final response = await SupabaseService.table('appointments')
          .select()
          .gte('date', today.toIso8601String())
          .lt('date', today.add(const Duration(days: 1)).toIso8601String());
      return (response as List)
          .map((a) => AppointmentModel.fromJson(a))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> createAppointment(AppointmentModel appointment) async {
    try {
      final response = await SupabaseService.table('appointments')
          .insert(appointment.toJson())
          .select();
      return response[0]['id'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateAppointment(String id, AppointmentModel appointment) async {
    try {
      await SupabaseService.table('appointments')
          .update(appointment.toJson())
          .eq('id', id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAppointment(String id) async {
    try {
      await SupabaseService.table('appointments').delete().eq('id', id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateAppointmentStatus(
    String id,
    String status,
  ) async {
    try {
      await SupabaseService.table('appointments')
          .update({'status': status}).eq('id', id);
    } catch (e) {
      rethrow;
    }
  }
}
