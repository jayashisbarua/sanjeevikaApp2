# Firebase Setup Guide for Sanjeevika App

This guide will help you set up Firebase for the Sanjeevika Flutter application.

## Prerequisites

- Google account
- Flutter project set up
- Android Studio / VS Code

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter project name: `sanjeevika-app`
4. Enable Google Analytics (optional)
5. Click "Create project"

## Step 2: Enable Authentication

1. In Firebase Console, go to "Authentication"
2. Click "Get started"
3. Go to "Sign-in method" tab
4. Enable "Email/Password" provider
5. Click "Save"

## Step 3: Set up Firestore Database

1. In Firebase Console, go to "Firestore Database"
2. Click "Create database"
3. Choose "Start in test mode" (for development)
4. Select a location (choose closest to your users)
5. Click "Done"

### Firestore Security Rules

Update your Firestore security rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Prescriptions - users can read/write their own
    match /prescriptions/{prescriptionId} {
      allow read, write: if request.auth != null;
    }
    
    // Lab orders - users can read/write their own
    match /lab_orders/{orderId} {
      allow read, write: if request.auth != null;
    }
    
    // Bills - users can read/write their own
    match /bills/{billId} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## Step 4: Add Android App

1. In Firebase Console, click the Android icon
2. Enter Android package name: `com.example.sanjeevika_app`
3. Enter app nickname: `Sanjeevika Android`
4. Click "Register app"
5. Download `google-services.json`
6. Place `google-services.json` in `android/app/` directory

## Step 5: Add iOS App (if needed)

1. In Firebase Console, click the iOS icon
2. Enter iOS bundle ID: `com.example.sanjeevikaApp`
3. Enter app nickname: `Sanjeevika iOS`
4. Click "Register app"
5. Download `GoogleService-Info.plist`
6. Place `GoogleService-Info.plist` in `ios/Runner/` directory

## Step 6: Update Android Configuration

### android/build.gradle

Add to the bottom of the file:

```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.3.15'
    }
}
```

### android/app/build.gradle

Add at the bottom of the file:

```gradle
apply plugin: 'com.google.gms.google-services'
```

## Step 7: Update iOS Configuration (if needed)

### ios/Runner/AppDelegate.swift

Add Firebase initialization:

```swift
import UIKit
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

## Step 8: Test Firebase Connection

1. Run the app: `flutter run`
2. Try to sign up with a new account
3. Check Firebase Console > Authentication to see if user was created
4. Check Firestore Database to see if user document was created

## Step 9: Environment Variables (Optional)

Create a `.env` file in the project root:

```env
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_API_KEY=your-api-key
```

## Troubleshooting

### Common Issues

1. **Build fails with Firebase error**
   - Make sure `google-services.json` is in the correct location
   - Check that the package name matches exactly

2. **Authentication not working**
   - Verify Email/Password provider is enabled
   - Check Firestore security rules

3. **Permission denied errors**
   - Update Firestore security rules
   - Check if user is authenticated

### Useful Commands

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter run

# Check Firebase configuration
flutter doctor
```

## Production Setup

For production deployment:

1. **Update Security Rules**: Use more restrictive rules
2. **Enable App Check**: Add app verification
3. **Set up Monitoring**: Enable Crashlytics
4. **Configure Analytics**: Set up custom events
5. **Backup Strategy**: Set up automated backups

## Support

If you encounter issues:

1. Check [Firebase Documentation](https://firebase.google.com/docs)
2. Check [Flutter Firebase Documentation](https://firebase.flutter.dev/)
3. Create an issue in the project repository

## Security Best Practices

1. **Never commit sensitive files**:
   - Add `google-services.json` and `GoogleService-Info.plist` to `.gitignore`
   - Use environment variables for sensitive data

2. **Use proper security rules**:
   - Restrict access based on user authentication
   - Validate data on both client and server

3. **Regular updates**:
   - Keep Firebase SDKs updated
   - Monitor for security advisories

4. **Backup strategy**:
   - Set up automated Firestore backups
   - Test restore procedures regularly
