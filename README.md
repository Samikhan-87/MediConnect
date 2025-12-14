# MediConnect - Doctor Appointment Mobile App

A Flutter-based mobile application for patients to book doctor appointments. This is the patient-side application with a clean MVC architecture.

## 📱 Features

### Implemented Screens
- ✅ **Splash Screen** - Animated logo with smooth transitions
- ✅ **Onboarding Screens** - 3 beautiful onboarding pages with slider
- ✅ **Login Screen** - User authentication with email and password
- ✅ **Sign Up Screen** - User registration with full details
- ✅ **Forgot Password Screen** - Two-step password reset flow

### Architecture
- **MVC Pattern** - Clean separation of concerns
  - **Models** - Data structures and business logic
  - **Views** - UI components and screens
  - **Controllers** - Business logic and state management

### Authentication
- **Local Storage** - Uses SharedPreferences for user data storage
- No backend integration required (ready for Firebase integration in future)
- Secure password validation and management

## 🏗️ Project Structure

```
lib/
├── controllers/          # Business logic & state management
│   ├── auth_controller.dart
│   ├── onboarding_controller.dart
│   └── splash_controller.dart
├── models/              # Data models
│   └── onboarding_model.dart
├── views/               # UI screens
│   ├── auth/
│   │   ├── forgot_password_view.dart
│   │   ├── login_view.dart
│   │   └── signup_view.dart
│   ├── onboarding/
│   │   └── onboarding_view.dart
│   └── splash/
│       └── splash_view.dart
├── routes/              # Navigation
│   └── app_router.dart
├── theme/               # App theming
│   └── app_theme.dart
└── widgets/             # Reusable UI components
    ├── custom_button.dart
    └── custom_text_field.dart
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code
- Android Emulator or Physical Device

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Samikhan-87/MediConnect.git
   cd MediConnect
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

- `flutter_svg` - SVG image support
- `google_fonts` - Custom fonts
- `shared_preferences` - Local storage
- `smooth_page_indicator` - Page indicators for onboarding

## 🎨 Design

- **Color Scheme**: Dark blue theme (#003366)
- **Typography**: Inter font family
- **UI Components**: Custom reusable widgets
- **Animations**: Smooth transitions and page indicators

## 📝 User Flow

1. **Splash Screen** → Shows animated logo
2. **Onboarding** → 3 screens with feature highlights (first time only)
3. **Login** → User authentication
4. **Sign Up** → New user registration
5. **Forgot Password** → Password reset flow

## 🔐 Authentication System

Currently using **SharedPreferences** for local storage:
- User registration and login
- Password management
- Session management

**Note**: Ready for Firebase integration when needed.

## 🛠️ Development

### MVC Architecture Benefits
- **Scalable**: Easy to add new features
- **Maintainable**: Clear separation of concerns
- **Testable**: Controllers can be tested independently
- **Clean**: Follows Flutter best practices

## 📱 Screenshots

(Add screenshots of your app here)

## 🔮 Future Enhancements

- [ ] Home screen implementation
- [ ] Doctor listing and search
- [ ] Appointment booking
- [ ] Firebase integration
- [ ] Push notifications
- [ ] Profile management

## 📄 License

This project is private and proprietary.

## 👨‍💻 Author

**Samikhan-87**

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Design inspiration from modern healthcare apps

---

Made with ❤️ using Flutter
