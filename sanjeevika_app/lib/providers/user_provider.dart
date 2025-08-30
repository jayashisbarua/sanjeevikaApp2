import 'package:flutter/material.dart';
import 'package:sanjeevika_app/models/prescription_model.dart';
import 'package:sanjeevika_app/models/lab_test_model.dart';

class UserProvider with ChangeNotifier {
  PrescriptionModel? _currentPrescription;
  LabTestOrderModel? _currentLabOrder;
  List<LabTestItem> _selectedTests = [];
  bool _isLoading = false;

  PrescriptionModel? get currentPrescription => _currentPrescription;
  LabTestOrderModel? get currentLabOrder => _currentLabOrder;
  List<LabTestItem> get selectedTests => _selectedTests;
  bool get isLoading => _isLoading;

  double get totalLabTestCost {
    return _selectedTests.fold(0, (sum, test) => sum + test.price);
  }

  double get totalMedicineCost {
    if (_currentPrescription == null) return 0;
    return _currentPrescription!.medicines.fold(
      0,
      (sum, medicine) => sum + medicine.totalPrice,
    );
  }

  void setCurrentPrescription(PrescriptionModel prescription) {
    _currentPrescription = prescription;
    notifyListeners();
  }

  void setCurrentLabOrder(LabTestOrderModel labOrder) {
    _currentLabOrder = labOrder;
    _selectedTests = labOrder.tests.map((test) => test.copyWith(isSelected: false)).toList();
    notifyListeners();
  }

  void toggleTestSelection(int index) {
    if (index >= 0 && index < _selectedTests.length) {
      _selectedTests[index] = _selectedTests[index].copyWith(
        isSelected: !_selectedTests[index].isSelected,
      );
      notifyListeners();
    }
  }

  void selectAllTests() {
    _selectedTests = _selectedTests.map((test) => test.copyWith(isSelected: true)).toList();
    notifyListeners();
  }

  void clearTestSelection() {
    _selectedTests = _selectedTests.map((test) => test.copyWith(isSelected: false)).toList();
    notifyListeners();
  }

  void clearCurrentData() {
    _currentPrescription = null;
    _currentLabOrder = null;
    _selectedTests = [];
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
