import 'package:json_annotation/json_annotation.dart';

part 'lab_test_model.g.dart';

@JsonSerializable()
class LabTestOrderModel {
  final String id;
  final String patientName;
  final String doctorName;
  final DateTime orderDate;
  final List<LabTestItem> tests;
  final String? notes;

  LabTestOrderModel({
    required this.id,
    required this.patientName,
    required this.doctorName,
    required this.orderDate,
    required this.tests,
    this.notes,
  });

  factory LabTestOrderModel.fromJson(Map<String, dynamic> json) =>
      _$LabTestOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$LabTestOrderModelToJson(this);
}

@JsonSerializable()
class LabTestItem {
  final String name;
  final String description;
  final double price;
  final String? instructions;
  final bool isSelected;

  LabTestItem({
    required this.name,
    required this.description,
    required this.price,
    this.instructions,
    this.isSelected = false,
  });

  factory LabTestItem.fromJson(Map<String, dynamic> json) =>
      _$LabTestItemFromJson(json);

  Map<String, dynamic> toJson() => _$LabTestItemToJson(this);

  LabTestItem copyWith({
    String? name,
    String? description,
    double? price,
    String? instructions,
    bool? isSelected,
  }) {
    return LabTestItem(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      instructions: instructions ?? this.instructions,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
