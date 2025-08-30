import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanjeevika_app/models/prescription_model.dart';
import 'package:sanjeevika_app/providers/user_provider.dart';
import 'package:sanjeevika_app/utils/theme.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class MedicineBillScreen extends StatelessWidget {
  const MedicineBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final prescription = userProvider.currentPrescription;
        
        if (prescription == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Medicine Bill')),
            body: const Center(
              child: Text('No prescription data available'),
            ),
          );
        }

        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          appBar: AppBar(
            title: const Text('Medicine Bill'),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => _shareBill(context, prescription, userProvider),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Bill Header
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SANJEEVIKA',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.primaryColor,
                                  ),
                                ),
                                Text(
                                  'Medical Store',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.textSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'BILL',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textPrimaryColor,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd/MM/yyyy').format(DateTime.now()),
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppTheme.textSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 32),
                        
                        // Patient and Prescription Info
                        _buildBillInfoRow('Patient Name', prescription.patientName),
                        _buildBillInfoRow('Doctor Name', prescription.doctorName),
                        _buildBillInfoRow('Prescription ID', prescription.id),
                        _buildBillInfoRow('Date', DateFormat('dd/MM/yyyy').format(prescription.prescriptionDate)),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Medicine Items Table
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Medicine Details',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Table Header
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              Expanded(flex: 3, child: Text('Medicine', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(child: Text('Qty', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                              Expanded(child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                              Expanded(child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Medicine Items
                        ...prescription.medicines.map((medicine) => 
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: AppTheme.dividerColor)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        medicine.name,
                                        style: const TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        medicine.dosage,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppTheme.textSecondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '${medicine.totalQuantity}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '₹${medicine.pricePerUnit?.toStringAsFixed(2) ?? '0.00'}',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '₹${medicine.totalPrice.toStringAsFixed(2)}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Bill Summary
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal:',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '₹${userProvider.totalMedicineCost.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'GST (5%):',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              '₹${(userProvider.totalMedicineCost * 0.05).toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Amount:',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                            Text(
                              '₹${(userProvider.totalMedicineCost * 1.05).toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Back'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _shareBill(context, prescription, userProvider),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Share Bill'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBillInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondaryColor,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppTheme.textPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  void _shareBill(BuildContext context, PrescriptionModel prescription, UserProvider userProvider) {
    final billText = _generateBillText(prescription, userProvider);
    
    Share.share(
      billText,
      subject: 'Medicine Bill - ${prescription.patientName}',
    );
  }

  String _generateBillText(PrescriptionModel prescription, UserProvider userProvider) {
    final buffer = StringBuffer();
    
    buffer.writeln('SANJEEVIKA - Medical Store');
    buffer.writeln('Medicine Bill');
    buffer.writeln('Date: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}');
    buffer.writeln('');
    buffer.writeln('Patient: ${prescription.patientName}');
    buffer.writeln('Doctor: ${prescription.doctorName}');
    buffer.writeln('Prescription ID: ${prescription.id}');
    buffer.writeln('');
    buffer.writeln('Medicine Details:');
    buffer.writeln('${'Medicine'.padRight(20)} ${'Qty'.padLeft(5)} ${'Price'.padLeft(10)} ${'Total'.padLeft(10)}');
    buffer.writeln('${'-' * 50}');
    
    for (final medicine in prescription.medicines) {
      buffer.writeln('${medicine.name.padRight(20)} ${medicine.totalQuantity.toString().padLeft(5)} ${(medicine.pricePerUnit ?? 0).toStringAsFixed(2).padLeft(10)} ${medicine.totalPrice.toStringAsFixed(2).padLeft(10)}');
    }
    
    buffer.writeln('');
    buffer.writeln('Subtotal: ₹${userProvider.totalMedicineCost.toStringAsFixed(2)}');
    buffer.writeln('GST (5%): ₹${(userProvider.totalMedicineCost * 0.05).toStringAsFixed(2)}');
    buffer.writeln('Total: ₹${(userProvider.totalMedicineCost * 1.05).toStringAsFixed(2)}');
    buffer.writeln('');
    buffer.writeln('Thank you for choosing Sanjeevika!');
    
    return buffer.toString();
  }
}
