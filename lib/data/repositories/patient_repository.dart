import 'package:dentalflow/core/services/supabase_service.dart';
import 'package:dentalflow/data/models/patient_model.dart';

class PatientRepository {
  static final PatientRepository _instance = PatientRepository._internal();

  factory PatientRepository() {
    return _instance;
  }

  PatientRepository._internal();

  Future<List<PatientModel>> getAllPatients() async {
    try {
      final response = await SupabaseService.table('patients').select();
      return (response as List)
          .map((p) => PatientModel.fromJson(p))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<PatientModel?> getPatientById(String id) async {
    try {
      final response = await SupabaseService.table('patients')
          .select()
          .eq('id', id)
          .single();
      return PatientModel.fromJson(response);
    } catch (e) {
      return null;
    }
  }

  Future<List<PatientModel>> searchPatients(String query) async {
    try {
      final response = await SupabaseService.table('patients')
          .select()
          .or('full_name.ilike.%$query%,phone.ilike.%$query%');
      return (response as List)
          .map((p) => PatientModel.fromJson(p))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> createPatient(PatientModel patient) async {
    try {
      final response = await SupabaseService.table('patients')
          .insert(patient.toJson())
          .select();
      return response[0]['id'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePatient(String id, PatientModel patient) async {
    try {
      await SupabaseService.table('patients')
          .update(patient.toJson())
          .eq('id', id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePatient(String id) async {
    try {
      await SupabaseService.table('patients').delete().eq('id', id);
    } catch (e) {
      rethrow;
    }
  }
}
