enum AppointmentStatus {
  booked,
  confirmed,
  checkedIn,
  withDoctor,
  completed,
  cancelled,
  noShow
}

class AppointmentModel {
  final String id;
  final String patientId;
  final String doctorId;
  final DateTime date;
  final DateTime time;
  final int duration; // in minutes
  final String reason;
  final AppointmentStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.date,
    required this.time,
    required this.duration,
    required this.reason,
    required this.status,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] as String,
      patientId: json['patient_id'] as String,
      doctorId: json['doctor_id'] as String,
      date: DateTime.parse(json['date'] as String),
      time: DateTime.parse(json['time'] as String),
      duration: json['duration'] as int,
      reason: json['reason'] as String,
      status: AppointmentStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => AppointmentStatus.booked,
      ),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'patient_id': patientId,
        'doctor_id': doctorId,
        'date': date.toIso8601String(),
        'time': time.toIso8601String(),
        'duration': duration,
        'reason': reason,
        'status': status.name,
        'notes': notes,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
