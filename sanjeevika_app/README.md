# Sanjeevika - Medical QR Code Scanner & Billing App

A comprehensive Flutter application designed for medical professionals to scan QR codes, manage prescriptions, and generate bills for patients.

## Features

### 🔐 Authentication & Role Management
- **User Registration**: Sign up with email and password
- **Role Selection**: Choose between Medicine Vendor or Lab Technician
- **Secure Login**: Firebase Authentication integration
- **Profile Management**: Update personal information

### 🏥 Medicine Vendor Workflow
- **QR Code Scanning**: Scan prescription QR codes using device camera
- **Prescription Display**: View detailed prescription information
- **Quantity Calculation**: Automatic calculation of medicine quantities
- **E-Bill Generation**: Generate professional bills with GST calculation
- **Bill Sharing**: Share bills via email, messaging, or social media

### 🧪 Lab Technician Workflow
- **QR Code Scanning**: Scan lab test order QR codes
- **Test Selection**: Choose which tests to perform
- **Cost Calculation**: Real-time cost calculation for selected tests
- **E-Bill Generation**: Generate lab test bills
- **Bill Sharing**: Share bills with patients

## Technical Stack

- **Framework**: Flutter 3.0+
- **State Management**: Provider
- **Backend**: Firebase (Firestore, Authentication)
- **QR Code Scanning**: qr_code_scanner
- **UI Components**: Material Design 3
- **Fonts**: Google Fonts (Poppins)

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── user_model.dart
│   ├── prescription_model.dart
│   └── lab_test_model.dart
├── providers/               # State management
│   ├── auth_provider.dart
│   └── user_provider.dart
├── screens/                 # UI screens
│   ├── splash_screen.dart
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   ├── dashboard/
│   │   ├── dashboard_screen.dart
│   │   ├── medicine_vendor_dashboard.dart
│   │   └── lab_technician_dashboard.dart
│   ├── qr_scanner/
│   │   └── qr_scanner_screen.dart
│   ├── prescription/
│   │   └── prescription_details_screen.dart
│   ├── lab_test/
│   │   └── lab_test_details_screen.dart
│   └── billing/
│       ├── medicine_bill_screen.dart
│       └── lab_test_bill_screen.dart
└── utils/
    └── theme.dart           # App theme configuration
```

## Setup Instructions

### Prerequisites
- Flutter SDK 3.0 or higher
- Android Studio / VS Code
- Firebase project setup

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd sanjeevika_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project
   - Enable Authentication (Email/Password)
   - Enable Firestore Database
   - Download and add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)

4. **Run the app**
   ```bash
   flutter run
   ```

### Building for Production

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

## QR Code Format

The app expects QR codes to contain JSON data in the following formats:

### Prescription QR Code Format
```json
{
  "id": "PRES001",
  "patientName": "John Doe",
  "doctorName": "Dr. Smith",
  "prescriptionDate": "2024-01-15T10:30:00Z",
  "medicines": [
    {
      "name": "Paracetamol",
      "dosage": "500mg",
      "frequency": 3,
      "duration": 7,
      "instructions": "Take after meals",
      "pricePerUnit": 2.50
    }
  ],
  "notes": "Take as prescribed"
}
```

### Lab Test QR Code Format
```json
{
  "id": "LAB001",
  "patientName": "John Doe",
  "doctorName": "Dr. Smith",
  "orderDate": "2024-01-15T10:30:00Z",
  "tests": [
    {
      "name": "Blood Test",
      "description": "Complete Blood Count",
      "price": 500.00,
      "instructions": "Fasting required"
    }
  ],
  "notes": "Urgent test required"
}
```

## Features in Detail

### Medicine Vendor Features
- **Dashboard**: Overview of recent activities
- **QR Scanner**: Camera-based QR code scanning
- **Prescription View**: Detailed medicine list with dosages
- **Bill Generation**: Professional bill with itemized list
- **Cost Calculation**: Automatic quantity and price calculation
- **Bill Sharing**: Multiple sharing options

### Lab Technician Features
- **Dashboard**: Lab-specific overview
- **QR Scanner**: Scan lab test orders
- **Test Selection**: Choose which tests to perform
- **Cost Tracking**: Real-time cost calculation
- **Bill Generation**: Lab test specific billing
- **Report Management**: Track test orders

## Security Features

- **Firebase Authentication**: Secure user login
- **Role-based Access**: Different features for different roles
- **Data Validation**: Input validation and sanitization
- **Secure Storage**: Firebase Firestore for data storage

## UI/UX Features

- **Material Design 3**: Modern, clean interface
- **Responsive Design**: Works on various screen sizes
- **Dark/Light Theme Support**: Theme customization
- **Intuitive Navigation**: Easy-to-use interface
- **Loading States**: Proper loading indicators
- **Error Handling**: User-friendly error messages

## Dependencies

Key dependencies used in this project:

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6
  qr_code_scanner: ^1.0.1
  qr_flutter: ^4.1.0
  camera: ^0.10.5+5
  google_fonts: ^6.1.0
  share_plus: ^7.2.1
  intl: ^0.18.1
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please contact the development team or create an issue in the repository.

## Version History

- **v1.0.0**: Initial release with basic QR scanning and billing features
- Future versions will include additional features like offline support, advanced analytics, and more payment options.
