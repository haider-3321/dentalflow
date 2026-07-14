enum UserRole { admin, doctor, secretary }

enum UserStatus { active, inactive, suspended }

class UserModel {
  final String id;
  final String username;
  final String email;
  final String? phone;
  final String? firstName;
  final String? lastName;
  final UserRole role;
  final UserStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? specialization; // For doctors
  final String? license; // For doctors

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.phone,
    this.firstName,
    this.lastName,
    required this.role,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.specialization,
    this.license,
  });

  String get fullName => '${firstName ?? ''} ${lastName ?? ''}'.trim();

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      role: UserRole.values.firstWhere(
        (e) => e.name == json['role'],
        orElse: () => UserRole.secretary,
      ),
      status: UserStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => UserStatus.active,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      specialization: json['specialization'] as String?,
      license: json['license'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
        'phone': phone,
        'first_name': firstName,
        'last_name': lastName,
        'role': role.name,
        'status': status.name,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'specialization': specialization,
        'license': license,
      };
}
