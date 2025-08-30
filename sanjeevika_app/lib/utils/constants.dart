class AppConstants {
  // App Information
  static const String appName = 'Sanjeevika';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Medical QR Code Scanner & Billing App';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String prescriptionsCollection = 'prescriptions';
  static const String labOrdersCollection = 'lab_orders';
  static const String billsCollection = 'bills';
  
  // User Roles
  static const String roleMedicineVendor = 'medicine_vendor';
  static const String roleLabTechnician = 'lab_technician';
  
  // Validation
  static const int minPasswordLength = 6;
  static const int maxNameLength = 50;
  static const int maxEmailLength = 100;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 2.0;
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Error Messages
  static const String genericError = 'Something went wrong. Please try again.';
  static const String networkError = 'Network error. Please check your connection.';
  static const String authError = 'Authentication failed. Please check your credentials.';
  static const String qrScanError = 'Invalid QR code. Please try again.';
  
  // Success Messages
  static const String loginSuccess = 'Login successful!';
  static const String signupSuccess = 'Account created successfully!';
  static const String billGenerated = 'Bill generated successfully!';
  static const String billShared = 'Bill shared successfully!';
  
  // Currency
  static const String currencySymbol = '₹';
  static const double gstRate = 0.05; // 5%
  
  // QR Code Formats
  static const String prescriptionQRPrefix = 'PRES';
  static const String labTestQRPrefix = 'LAB';
  
  // File Extensions
  static const String pdfExtension = '.pdf';
  static const String imageExtension = '.png';
  
  // Share Options
  static const List<String> shareOptions = [
    'Email',
    'WhatsApp',
    'SMS',
    'Copy Link',
    'Save to Files'
  ];
  
  // Test Data
  static const String testEmail = 'test@example.com';
  static const String testPassword = 'password123';
  static const String testName = 'Test User';
  
  // API Endpoints (if needed in future)
  static const String baseUrl = 'https://api.sanjeevika.com';
  static const String authEndpoint = '/auth';
  static const String userEndpoint = '/user';
  static const String prescriptionEndpoint = '/prescription';
  static const String labTestEndpoint = '/lab-test';
}
