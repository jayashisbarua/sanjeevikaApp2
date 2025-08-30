import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanjeevika_app/models/lab_test_model.dart';
import 'package:sanjeevika_app/providers/user_provider.dart';
import 'package:sanjeevika_app/utils/theme.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';

class LabTestBillScreen extends StatelessWidget {
  const LabTestBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        final labOrder = userProvider.currentLabOrder;
        final selectedTests = userProvider.selectedTests.where((test) => test.isSelected).toList();
        
        if (labOrder == null || selectedTests.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: const Text('Lab Test Bill')),
            body: const Center(
              child: Text('No lab test data available'),
            ),
          );
        }

        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          appBar: AppBar(
            title: const Text('Lab Test Bill'),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => _shareBill(context, labOrder, selectedTests, userProvider),
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
                                    color: AppTheme.secondaryColor,
                                  ),
                                ),
                                Text(
                                  'Laboratory Services',
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
                        
                        // Patient and Lab Order Info
                        _buildBillInfoRow('Patient Name', labOrder.patientName),
                        _buildBillInfoRow('Doctor Name', labOrder.doctorName),
                        _buildBillInfoRow('Lab Order ID', labOrder.id),
                        _buildBillInfoRow('Order Date', DateFormat('dd/MM/yyyy').format(labOrder.orderDate)),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Lab Test Items Table
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selected Lab Tests',
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
                            color: AppTheme.secondaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              Expanded(flex: 3, child: Text('Test Name', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(child: Text('Price', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Test Items
                        ...selectedTests.map((test) => 
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
                                        test.name,
                                        style: const TextStyle(fontWeight: FontWeight.w600),
                                      ),
                                      if (test.description.isNotEmpty)
                                        Text(
                                          test.description,
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
                                    '₹${test.price.toStringAsFixed(2)}',
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
                              '₹${userProvider.totalLabTestCost.toStringAsFixed(2)}',
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
                              '₹${(userProvider.totalLabTestCost * 0.05).toStringAsFixed(2)}',
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
                                color: AppTheme.secondaryColor,
                              ),
                            ),
                            Text(
                              '₹${(userProvider.totalLabTestCost * 1.05).toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.secondaryColor,
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
                        onPressed: () => _shareBill(context, labOrder, selectedTests, userProvider),
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

  void _shareBill(BuildContext context, LabTestOrderModel labOrder, List<LabTestItem> selectedTests, UserProvider userProvider) {
    final billText = _generateBillText(labOrder, selectedTests, userProvider);
    
    Share.share(
      billText,
      subject: 'Lab Test Bill - ${labOrder.patientName}',
    );
  }

  String _generateBillText(LabTestOrderModel labOrder, List<LabTestItem> selectedTests, UserProvider userProvider) {
    final buffer = StringBuffer();
    
    buffer.writeln('SANJEEVIKA - Laboratory Services');
    buffer.writeln('Lab Test Bill');
    buffer.writeln('Date: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}');
    buffer.writeln('');
    buffer.writeln('Patient: ${labOrder.patientName}');
    buffer.writeln('Doctor: ${labOrder.doctorName}');
    buffer.writeln('Lab Order ID: ${labOrder.id}');
    buffer.writeln('');
    buffer.writeln('Selected Tests:');
    buffer.writeln('${'Test Name'.padRight(30)} ${'Price'.padLeft(10)}');
    buffer.writeln('${'-' * 45}');
    
    for (final test in selectedTests) {
      buffer.writeln('${test.name.padRight(30)} ${test.price.toStringAsFixed(2).padLeft(10)}');
      if (test.description.isNotEmpty) {
        buffer.writeln('  ${test.description}');
      }
    }
    
    buffer.writeln('');
    buffer.writeln('Subtotal: ₹${userProvider.totalLabTestCost.toStringAsFixed(2)}');
    buffer.writeln('GST (5%): ₹${(userProvider.totalLabTestCost * 0.05).toStringAsFixed(2)}');
    buffer.writeln('Total: ₹${(userProvider.totalLabTestCost * 1.05).toStringAsFixed(2)}');
    buffer.writeln('');
    buffer.writeln('Thank you for choosing Sanjeevika!');
    
    return buffer.toString();
  }
}
