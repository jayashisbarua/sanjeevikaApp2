import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanjeevika_app/models/prescription_model.dart';
import 'package:sanjeevika_app/providers/user_provider.dart';
import 'package:sanjeevika_app/screens/billing/medicine_bill_screen.dart';
import 'package:sanjeevika_app/utils/theme.dart';
import 'package:intl/intl.dart';

class PrescriptionDetailsScreen extends StatelessWidget {
  const PrescriptionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final prescription = userProvider.currentPrescription;
        
        if (prescription == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Prescription Details')),
            body: const Center(
              child: Text('No prescription data available'),
            ),
          );
        }

        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          appBar: AppBar(
            title: const Text('Prescription Details'),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  userProvider.clearCurrentData();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Prescription Header Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.medical_services,
                                color: AppTheme.primaryColor,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Prescription',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: AppTheme.textSecondaryColor,
                                    ),
                                  ),
                                  Text(
                                    prescription.id,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        // Patient and Doctor Info
                        _buildInfoRow('Patient', prescription.patientName),
                        _buildInfoRow('Doctor', prescription.doctorName),
                        _buildInfoRow(
                          'Date', 
                          DateFormat('MMM dd, yyyy').format(prescription.prescriptionDate),
                        ),
                        if (prescription.notes != null)
                          _buildInfoRow('Notes', prescription.notes!),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Medicines List
                Text(
                  'Prescribed Medicines',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Medicine Items
                ...prescription.medicines.map((medicine) => 
                  _buildMedicineCard(context, medicine),
                ),
                
                const SizedBox(height: 24),
                
                // Total Cost Summary
                Card(
                  color: AppTheme.primaryColor.withOpacity(0.05),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Cost:',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimaryColor,
                              ),
                            ),
                            Text(
                              '₹${userProvider.totalMedicineCost.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const MedicineBillScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text('Generate Bill'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppTheme.textPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineCard(BuildContext context, MedicineItem medicine) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    medicine.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimaryColor,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '₹${medicine.pricePerUnit?.toStringAsFixed(2) ?? '0.00'}',
                    style: TextStyle(
                      color: AppTheme.secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Medicine Details
            _buildMedicineDetail('Dosage', medicine.dosage),
            _buildMedicineDetail('Frequency', '${medicine.frequency} times/day'),
            _buildMedicineDetail('Duration', '${medicine.duration} days'),
            _buildMedicineDetail('Total Quantity', '${medicine.totalQuantity} units'),
            _buildMedicineDetail('Total Price', '₹${medicine.totalPrice.toStringAsFixed(2)}'),
            
            if (medicine.instructions != null)
              _buildMedicineDetail('Instructions', medicine.instructions!),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: AppTheme.textPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
