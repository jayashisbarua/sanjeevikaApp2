import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:provider/provider.dart';
import 'package:sanjeevika_app/models/user_model.dart';
import 'package:sanjeevika_app/models/prescription_model.dart';
import 'package:sanjeevika_app/models/lab_test_model.dart';
import 'package:sanjeevika_app/providers/auth_provider.dart';
import 'package:sanjeevika_app/providers/user_provider.dart';
import 'package:sanjeevika_app/screens/prescription/prescription_details_screen.dart';
import 'package:sanjeevika_app/screens/lab_test/lab_test_details_screen.dart';
import 'package:sanjeevika_app/utils/theme.dart';
import 'dart:convert';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool _isScanning = true;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).userModel!;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
        actions: [
          IconButton(
            icon: Icon(_isScanning ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              setState(() {
                _isScanning = !_isScanning;
              });
              if (_isScanning) {
                controller?.resumeCamera();
              } else {
                controller?.pauseCamera();
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // QR Scanner View
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: AppTheme.primaryColor,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: 300,
            ),
          ),
          
          // Instructions
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(
                    user.role == UserRole.medicineVendor 
                        ? Icons.medical_services 
                        : Icons.science,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.role == UserRole.medicineVendor
                        ? 'Scan Prescription QR Code'
                        : 'Scan Lab Test QR Code',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Position the QR code within the frame',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Flash Toggle
          Positioned(
            bottom: 100,
            right: 20,
            child: FloatingActionButton(
              onPressed: () async {
                await controller?.toggleFlash();
              },
              child: const Icon(Icons.flash_on),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        _handleScannedData(scanData.code!);
      }
    });
  }

  void _handleScannedData(String data) {
    // Pause scanning to prevent multiple scans
    controller?.pauseCamera();
    
    try {
      // Parse the QR code data
      final jsonData = json.decode(data);
      
      final user = Provider.of<AuthProvider>(context, listen: false).userModel!;
      
      if (user.role == UserRole.medicineVendor) {
        // Handle prescription data
        final prescription = PrescriptionModel.fromJson(jsonData);
        Provider.of<UserProvider>(context, listen: false)
            .setCurrentPrescription(prescription);
        
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const PrescriptionDetailsScreen(),
          ),
        );
      } else {
        // Handle lab test data
        final labOrder = LabTestOrderModel.fromJson(jsonData);
        Provider.of<UserProvider>(context, listen: false)
            .setCurrentLabOrder(labOrder);
        
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const LabTestDetailsScreen(),
          ),
        );
      }
    } catch (e) {
      // Handle invalid QR code data
      controller?.resumeCamera();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid QR code data: ${e.toString()}'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
