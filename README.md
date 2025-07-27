# premium_newsletter

A modern Flutter application built with clean architecture, featuring user profiles, newsletters, notices, and a curved navigation bar.

## Features

### 🎨 UI/UX
- Modern Material Design 3
- Animated curved navigation bar
- Splash screen with logo
- Dark/Light theme support
- Cached network images
- Smooth animations and transitions

### 🏗️ Architecture
- Clean Architecture (Domain, Data, Presentation layers)
- BLoC state management
- Dependency injection with GetIt
- Repository pattern
- Use cases for business logic

### 📱 Core Features
- **Authentication**: Login/Logout with demo credentials
- **Profile Management**: User profile with membership status
- **Newsletter**: List of newsletters with WebView integration
- **Notices**: Important alerts with priority levels
- **Settings Menu**: App configuration and user actions

### 🔧 Technical Features
- Image caching for better performance
- Local data persistence
- Future-ready AI integration structure
- Proper error handling
- Loading states and offline support

## Getting Started

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd modern_flutter_app
```

2. Install dependencies
```bash
flutter pub get
```

3. Add your logo image to `assets/images/logo.png`

4. Run the app
```bash
flutter run
```

### Demo Credentials
- Email: `demo@example.com`
- Password: `demo123`

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   ├── di/
│   ├── errors/
│   ├── network/
│   ├── router/
│   ├── theme/
│   └── utils/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── home/
│   ├── menu/
│   ├── newsletter/
│   ├── notices/
│   ├── splash/
│   └── user/
└── main.dart
```

## Dependencies

### Core
- `flutter_bloc`: State management
- `go_router`: Navigation
- `get_it`: Dependency injection
- `equatable`: Value equality

### UI/UX
- `curved_navigation_bar`: Animated navigation
- `cached_network_image`: Image caching
- `lottie`: Animations
- `webview_flutter`: Web content

### Storage & Network
- `shared_preferences`: Local storage
- `hive`: NoSQL database
- `dio`: HTTP client

## Future AI Integration

The app is structured to easily integrate AI features:

```dart
// Example AI service integration
class AIService {
  Future<String> getChatResponse(String message) async {
    // AI API integration
  }
  
  Future<List<String>> getRecommendations(UserEntity user) async {
    // AI-powered recommendations
  }
}
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.