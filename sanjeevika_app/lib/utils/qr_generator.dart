import 'dart:convert';
import 'package:sanjeevika_app/models/prescription_model.dart';
import 'package:sanjeevika_app/models/lab_test_model.dart';

class QRGenerator {
  /// Generate sample prescription QR code data
  static String generatePrescriptionQR() {
    final prescription = {
      "id": "PRES001",
      "patientName": "John Doe",
      "doctorName": "Dr. Sarah Smith",
      "prescriptionDate": "2024-01-15T10:30:00Z",
      "medicines": [
        {
          "name": "Paracetamol",
          "dosage": "500mg",
          "frequency": 3,
          "duration": 7,
          "instructions": "Take after meals",
          "pricePerUnit": 2.50
        },
        {
          "name": "Amoxicillin",
          "dosage": "250mg",
          "frequency": 2,
          "duration": 10,
          "instructions": "Take on empty stomach",
          "pricePerUnit": 5.00
        },
        {
          "name": "Vitamin C",
          "dosage": "1000mg",
          "frequency": 1,
          "duration": 14,
          "instructions": "Take in the morning",
          "pricePerUnit": 1.50
        }
      ],
      "notes": "Complete the full course of antibiotics"
    };

    return json.encode(prescription);
  }

  /// Generate sample lab test QR code data
  static String generateLabTestQR() {
    final labOrder = {
      "id": "LAB001",
      "patientName": "Jane Smith",
      "doctorName": "Dr. Michael Johnson",
      "orderDate": "2024-01-15T14:00:00Z",
      "tests": [
        {
          "name": "Complete Blood Count",
          "description": "Measures red blood cells, white blood cells, and platelets",
          "price": 500.00,
          "instructions": "Fasting required for 8 hours"
        },
        {
          "name": "Blood Sugar Test",
          "description": "Measures glucose levels in blood",
          "price": 300.00,
          "instructions": "Fasting required for 12 hours"
        },
        {
          "name": "Liver Function Test",
          "description": "Measures liver enzymes and proteins",
          "price": 800.00,
          "instructions": "Fasting required for 8 hours"
        },
        {
          "name": "Kidney Function Test",
          "description": "Measures kidney function markers",
          "price": 600.00,
          "instructions": "No special preparation required"
        }
      ],
      "notes": "Urgent tests required. Results needed within 24 hours."
    };

    return json.encode(labOrder);
  }

  /// Generate QR code data for testing medicine vendor workflow
  static String generateMedicineVendorTestQR() {
    final prescription = {
      "id": "PRES_TEST_001",
      "patientName": "Test Patient",
      "doctorName": "Dr. Test Doctor",
      "prescriptionDate": DateTime.now().toIso8601String(),
      "medicines": [
        {
          "name": "Test Medicine 1",
          "dosage": "100mg",
          "frequency": 2,
          "duration": 5,
          "instructions": "Take with water",
          "pricePerUnit": 10.00
        },
        {
          "name": "Test Medicine 2",
          "dosage": "50mg",
          "frequency": 1,
          "duration": 7,
          "instructions": "Take at bedtime",
          "pricePerUnit": 15.00
        }
      ],
      "notes": "Test prescription for development"
    };

    return json.encode(prescription);
  }

  /// Generate QR code data for testing lab technician workflow
  static String generateLabTechnicianTestQR() {
    final labOrder = {
      "id": "LAB_TEST_001",
      "patientName": "Test Patient",
      "doctorName": "Dr. Test Doctor",
      "orderDate": DateTime.now().toIso8601String(),
      "tests": [
        {
          "name": "Test Lab Test 1",
          "description": "Test description for development",
          "price": 200.00,
          "instructions": "Test instructions"
        },
        {
          "name": "Test Lab Test 2",
          "description": "Another test description",
          "price": 300.00,
          "instructions": "More test instructions"
        }
      ],
      "notes": "Test lab order for development"
    };

    return json.encode(labOrder);
  }
}
