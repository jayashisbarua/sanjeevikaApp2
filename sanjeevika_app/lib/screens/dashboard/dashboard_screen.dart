import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanjeevika_app/models/user_model.dart';
import 'package:sanjeevika_app/providers/auth_provider.dart';
import 'package:sanjeevika_app/screens/dashboard/medicine_vendor_dashboard.dart';
import 'package:sanjeevika_app/screens/dashboard/lab_technician_dashboard.dart';
import 'package:sanjeevika_app/utils/theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final user = authProvider.userModel;
        
        if (user == null) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Route to role-specific dashboard
        switch (user.role) {
          case UserRole.medicineVendor:
            return const MedicineVendorDashboard();
          case UserRole.labTechnician:
            return const LabTechnicianDashboard();
        }
      },
    );
  }
}
