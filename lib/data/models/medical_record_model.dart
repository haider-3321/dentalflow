class MedicalRecordModel {
  final String id;
  final String patientId;
  final String appointmentId;
  final String doctorId;
  final DateTime visitDate;
  final String? diagnosis;
  final String? treatment;
  final String? prescription;
  final String? notes;
  final List<String>? imageUrls; // X-rays, photos
  final DateTime createdAt;
  final DateTime? updatedAt;

  MedicalRecordModel({
    required this.id,
    required this.patientId,
    required this.appointmentId,
    required this.doctorId,
    required this.visitDate,
    this.diagnosis,
    this.treatment,
    this.prescription,
    this.notes,
    this.imageUrls,
    required this.createdAt,
    this.updatedAt,
  });

  factory MedicalRecordModel.fromJson(Map<String, dynamic> json) {
    return MedicalRecordModel(
      id: json['id'] as String,
      patientId: json['patient_id'] as String,
      appointmentId: json['appointment_id'] as String,
      doctorId: json['doctor_id'] as String,
      visitDate: DateTime.parse(json['visit_date'] as String),
      diagnosis: json['diagnosis'] as String?,
      treatment: json['treatment'] as String?,
      prescription: json['prescription'] as String?,
      notes: json['notes'] as String?,
      imageUrls: (json['image_urls'] as List?)?.cast<String>(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'patient_id': patientId,
        'appointment_id': appointmentId,
        'doctor_id': doctorId,
        'visit_date': visitDate.toIso8601String(),
        'diagnosis': diagnosis,
        'treatment': treatment,
        'prescription': prescription,
        'notes': notes,
        'image_urls': imageUrls,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
