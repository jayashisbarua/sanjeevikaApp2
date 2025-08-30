import 'package:json_annotation/json_annotation.dart';

part 'prescription_model.g.dart';

@JsonSerializable()
class PrescriptionModel {
  final String id;
  final String patientName;
  final String doctorName;
  final DateTime prescriptionDate;
  final List<MedicineItem> medicines;
  final String? notes;

  PrescriptionModel({
    required this.id,
    required this.patientName,
    required this.doctorName,
    required this.prescriptionDate,
    required this.medicines,
    this.notes,
  });

  factory PrescriptionModel.fromJson(Map<String, dynamic> json) =>
      _$PrescriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionModelToJson(this);
}

@JsonSerializable()
class MedicineItem {
  final String name;
  final String dosage;
  final int frequency; // times per day
  final int duration; // number of days
  final String? instructions;
  final double? pricePerUnit;

  MedicineItem({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.duration,
    this.instructions,
    this.pricePerUnit,
  });

  factory MedicineItem.fromJson(Map<String, dynamic> json) =>
      _$MedicineItemFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineItemToJson(this);

  int get totalQuantity {
    return frequency * duration;
  }

  double get totalPrice {
    return (pricePerUnit ?? 0) * totalQuantity;
  }
}
