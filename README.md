## 📝 Simple Login Flutter App

This is a **Flutter Firebase Authentication** app that allows users to log in using email and password. Once authenticated, the app navigates to the **Home Screen**, displaying the user's email and UID in an improved UI. It also includes a **logout** option.

---

### 📌 Features  
✔️ Firebase Authentication (Email/Password Login)  
✔️ Automatically checks if the user is already logged in (`main.dart`)  
✔️ Responsive UI with **Flutter ScreenUtil**  
✔️ Improved **Home Screen UI** for better display of user details  
✔️ Separated business logic into `LoginController`  
✔️ `auth_service.dart` created under `core/service/` for Firebase logic  
✔️ Centralized styling with `AppStyles`  
✔️ Clean code architecture and folder structure  

---

## 🛠️ Tech Stack  
- **Flutter** (Latest Stable)  
- **Dart**  
- **Firebase Authentication**  
- **Google Fonts**  
- **Flutter ScreenUtil**  
- **Clean Architecture** principles  

---

## 🚀 Installation Guide  

### 1️⃣ Prerequisites  
Ensure you have:  
✅ **Flutter SDK** installed → [Flutter Install Guide](https://flutter.dev/docs/get-started/install)  
✅ **Firebase Setup** for Flutter → [Firebase Setup Guide](https://firebase.google.com/docs/flutter/setup)  

### 2️⃣ Clone the Repository  
```sh
git clone https://github.com/jaybhavsar555/SimpleLoginFlutterApp.git
cd SimpleLoginFlutterApp
```

### 3️⃣ Install Dependencies  
```sh
flutter pub get
```

### 4️⃣ Configure Firebase  
- Replace `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) with your Firebase credentials.  
- Check `firebase_options.dart` for Firebase initialization.  

### 5️⃣ Run the App  
For Android:  
```sh
flutter run
```
For iOS:  
```sh
flutter run --no-sound-null-safety
```

---

## 📂 Project Structure  
```
📦 simple-login-flutter-app
 ┣ 📂 lib
 ┃ ┣ 📂 core
 ┃ ┃ ┣ 📂 service
 ┃ ┃ ┃ ┗ 📜 auth_service.dart      # FirebaseAuth logic layer
 ┃ ┣ 📂 screens
 ┃ ┃ ┣ 📜 login_screen.dart        # Login UI
 ┃ ┃ ┣ 📜 home_screen.dart         # Displays user details & logout
 ┃ ┣ 📂 controller
 ┃ ┃ ┗ 📜 login_controller.dart     # Handles login logic separately
 ┃ ┣ 📂 utils
 ┃ ┃ ┣ 📂 constants
 ┃ ┃ ┃ ┣ 📜 app_styles.dart        # Centralized theme & colors
 ┃ ┃ ┣ 📜 cmn_text.dart            # Reusable styled text widget
 ┃ ┣ 📜 main.dart                  # App entry point (auto-login check)
 ┣ 📜 pubspec.yaml                 # Dependencies
 ┣ 📜 README.md                    # Project Documentation
```

---

## 🔥 How It Works  

1️⃣ **Automatic Login Check**  
   - `main.dart` checks if the user is already logged in.  
   - Authenticated users go to the **Home Screen**.  
   - Others see the **Login Screen**.

2️⃣ **Login Logic Separated**  
   - `login_controller.dart` handles all login-related logic.  
   - Keeps UI clean and separated from logic.

3️⃣ **Firebase Integration Layer**  
   - `auth_service.dart` handles all FirebaseAuth calls like login, logout, error handling.  
   - Used inside controller → keeping logic modular and testable.

4️⃣ **Home Screen**  
   - Improved UI for displaying **user email** and **UID**  
   - Includes a logout button in the top-right corner  

---

## 🛠️ Troubleshooting  
- **App crashes on login?** Ensure your `firebase_options.dart` is correctly configured.  
- **Error: Missing google-services.json?** Download it from Firebase Console and place it in `android/app/`.  
- **White screen on launch?** Run `flutter clean && flutter pub get` and restart.  

---

## ✨ Future Improvements  
- ✅ Google & Facebook login  
- ✅ Dark mode support  
- ✅ Password reset feature  

---

## 📬 Contact  
If you have any issues, feel free to reach out! 🚀
