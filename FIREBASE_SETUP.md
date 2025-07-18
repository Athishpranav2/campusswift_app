# 🔐 Firebase Setup Guide

## Important Security Notice
**DO NOT COMMIT** these files to version control:
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `lib/firebase_options.dart`

## Setup Instructions for New Team Members

### 🚀 **Quick Setup (Recommended)**
1. Clone the repository
2. Install FlutterFire CLI:
   ```bash
   dart pub global activate flutterfire_cli
   ```
3. Configure Firebase for the project:
   ```bash
   flutterfire configure
   ```
4. Select the existing Firebase project: `sidekicker-4ef1b`
5. Choose platforms you need (Android, iOS, Web, etc.)

### 📱 **Manual Setup (Alternative)**
1. Get access to the Firebase project from team lead
2. Download configuration files:
   - `google-services.json` for Android
   - `GoogleService-Info.plist` for iOS
3. Get `firebase_options.dart` from team lead via secure channel
4. Place files in correct locations (see directory structure below)

### 1. Firebase Project Setup
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Access existing project: `sidekicker-4ef1b`
3. Enable Authentication > Sign-in method > Google

### 2. Android Setup
1. In Firebase Console, add Android app (if not exists)
2. Use package name: `com.example.campusswift_app`
3. Download `google-services.json`
4. Place it in `android/app/google-services.json`
5. **Never commit this file to Git**

### 3. iOS Setup (if needed)
1. In Firebase Console, add iOS app (if not exists)
2. Use bundle ID from `ios/Runner/Info.plist`
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/GoogleService-Info.plist`
5. **Never commit this file to Git**

### 4. Security Configuration
- The app restricts sign-in to `@psgtech.ac.in` emails only
- Rate limiting is enabled for authentication attempts
- Input validation and sanitization is implemented

### 5. File Structure
After setup, you should have:
```
├── android/app/
│   ├── google-services.json          # ❌ Never commit
│   └── google-services.json.example  # ✅ Template file
├── ios/Runner/
│   └── GoogleService-Info.plist      # ❌ Never commit  
├── lib/
│   ├── firebase_options.dart         # ❌ Never commit
│   └── firebase_options.dart.example # ✅ Template file
```

### 6. Environment Variables
Create these files locally (they are gitignored):
- `.env.local` for local development secrets
- `local.properties` for Android local configuration

## Template Files
Use the provided template files:
- `google-services.json.example` - Template for Android Firebase config
- `firebase_options.dart.example` - Template for Flutter Firebase config
- Replace placeholder values with your actual Firebase project details

## Team Communication
**For project maintainers:** Share the actual configuration files via:
- Secure messaging (Signal, encrypted Slack DMs)
- Team password manager (1Password, Bitwarden)
- Direct email to specific team members
- **Never share via public channels or commit to Git**
