enum BloodType { oPositive, oNegative, aPositive, aNegative, bPositive, bNegative, abPositive, abNegative }

enum Gender { male, female }

class PatientModel {
  final String id;
  final String fullName;
  final int age;
  final Gender gender;
  final String phone;
  final String? email;
  final String? address;
  final BloodType? bloodType;
  final List<String>? chronicDiseases;
  final List<String>? allergies;
  final List<String>? currentMedications;
  final String? emergencyContact;
  final String? emergencyPhone;
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  PatientModel({
    required this.id,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.phone,
    this.email,
    this.address,
    this.bloodType,
    this.chronicDiseases,
    this.allergies,
    this.currentMedications,
    this.emergencyContact,
    this.emergencyPhone,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      age: json['age'] as int,
      gender: Gender.values.firstWhere(
        (e) => e.name == json['gender'],
        orElse: () => Gender.male,
      ),
      phone: json['phone'] as String,
      email: json['email'] as String?,
      address: json['address'] as String?,
      bloodType: json['blood_type'] != null
          ? BloodType.values.firstWhere(
              (e) => e.name == json['blood_type'],
              orElse: () => BloodType.oPositive,
            )
          : null,
      chronicDiseases: (json['chronic_diseases'] as List?)?.cast<String>(),
      allergies: (json['allergies'] as List?)?.cast<String>(),
      currentMedications: (json['current_medications'] as List?)?.cast<String>(),
      emergencyContact: json['emergency_contact'] as String?,
      emergencyPhone: json['emergency_phone'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'full_name': fullName,
        'age': age,
        'gender': gender.name,
        'phone': phone,
        'email': email,
        'address': address,
        'blood_type': bloodType?.name,
        'chronic_diseases': chronicDiseases,
        'allergies': allergies,
        'current_medications': currentMedications,
        'emergency_contact': emergencyContact,
        'emergency_phone': emergencyPhone,
        'notes': notes,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
