# imperative_task

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



# 🚀 Flutter App with BLoC, Biometric Auth, Theme Mode & Connectivity Control

A scalable Flutter application built using **BLoC pattern** that demonstrates clean architecture, modularity, and integration of key production-ready features including:

- ✅ BLoC State Management
- 🔐 Biometric Login (Post-login prompt)
- 🌗 Dark & Light Theme Toggle
- 🌐 Internet Connectivity Detection (Centralized)
- 📡 REST API Integration

---

## 📁 Project Structure

lib/
│
├── bloc/                  # All BLoC files (events, states, blocs)
│   ├── base/              # base bloc to extend with other bloc           
│   ├── login/             # Login bloc
|   ├── transaction        # transaction bloc
|   ├── biometric          # biometric bloc
│   ├── connectivity/      # Internet connection bloc
│   └── theme/             # Light/Dark theme bloc
│
├── model/                 # Data models parsed from APIs
│   ├── login_model.dart
│   └── transaction_list_model.dart
│
├── repository/            # Abstracted data sources for APIs
│   ├── login_repository.dart
│   └── transaction_repository.dart
│
├── network/               # Network layer (Dio setup, interceptors)
│   ├── api_client.dart
│   └── network_helper.dart
│
├── screens/               # All UI Screens
│   ├── login/             # Login screen & widgets
│   └── transaction/       # Other feature screens
│
├── utility/               # Shared utilities
│   ├── constants/         # App-wide constants (colors, strings, keys)
│   ├── widgets/           # Common reusable widgets
│   └── functions/         # Utility functions (, toast, etc.)
│
└── main.dart              # App entry point with BlocProviders and router


## 🛠️ Features

| Feature                     | Description                                                                 |
|----------------------------|-----------------------------------------------------------------------------|
| 🔄 BLoC                     | Modular BLoC setup for state management across features                     |
| 🌐 API Integration         | REST API calls via Dio                                                      |
| 🧠 Central Connectivity     | App won't allow API screens without internet (using global BLoC)           |
| 🌓 Dark/Light Theme Toggle | UI switch with dynamic theme handling                                      |
| 🔐 Biometric Auth          | Prompt after login, stored using `SharedPreferences` for auto-auth checks |


## 📲 Setup Instructions

Follow these steps to set up and run the Flutter project locally:

### ✅ Prerequisites
- Flutter SDK (latest stable version recommended)
- Dart SDK
- Android Studio / VS Code with Flutter plugin
- Android/iOS emulator or physical device


### 🔧 Clone the Repository
```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
```

Install Dependencies
```bash
flutter pub get
```
Run the App
```bash
flutter run
```

###  APK Build Instructions
To generate a release APK:
```bash
flutter build apk --release
```
The APK will be located in location:
build/app/outputs/flutter-apk/app-release.apk

### Bonus Features
Centralized internet check using Bloc
Seamless dark/light mode support via Bloc.
Custom animations on Login screen.
Professional UI with reusable components.

