enum PaymentMethod { cash, card, check, transfer }

class FinancialRecordModel {
  final String id;
  final String appointmentId;
  final String patientId;
  final double treatmentCost;
  final double paidAmount;
  final double remainingAmount;
  final PaymentMethod paymentMethod;
  final DateTime dateTime;
  final String? notes;

  FinancialRecordModel({
    required this.id,
    required this.appointmentId,
    required this.patientId,
    required this.treatmentCost,
    required this.paidAmount,
    required this.remainingAmount,
    required this.paymentMethod,
    required this.dateTime,
    this.notes,
  });

  factory FinancialRecordModel.fromJson(Map<String, dynamic> json) {
    return FinancialRecordModel(
      id: json['id'] as String,
      appointmentId: json['appointment_id'] as String,
      patientId: json['patient_id'] as String,
      treatmentCost: (json['treatment_cost'] as num).toDouble(),
      paidAmount: (json['paid_amount'] as num).toDouble(),
      remainingAmount: (json['remaining_amount'] as num).toDouble(),
      paymentMethod: PaymentMethod.values.firstWhere(
        (e) => e.name == json['payment_method'],
        orElse: () => PaymentMethod.cash,
      ),
      dateTime: DateTime.parse(json['date_time'] as String),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'appointment_id': appointmentId,
        'patient_id': patientId,
        'treatment_cost': treatmentCost,
        'paid_amount': paidAmount,
        'remaining_amount': remainingAmount,
        'payment_method': paymentMethod.name,
        'date_time': dateTime.toIso8601String(),
        'notes': notes,
      };
}
