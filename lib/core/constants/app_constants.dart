class AppConstants {
  // App Information
  static const String appName = 'Modern Flutter App';
  static const String appVersion = '1.0.0';

  // API Endpoints (for future AI integration)
  static const String baseUrl = 'https://api.modernapp.com';
  static const String aiEndpoint = '/api/v1/ai';
  static const String userEndpoint = '/api/v1/user';
  static const String newsletterEndpoint = '/api/v1/newsletters';
  static const String noticesEndpoint = '/api/v1/notices';

  // Cache Settings
  static const Duration cacheValidDuration = Duration(hours: 24);
  static const int maxCacheSize = 100; // MB

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  // Pagination
  static const int defaultPageSize = 20;

  // AI Integration (Future Implementation)
  static const String aiApiKey = 'your_ai_api_key_here';
  static const Map<String, String> aiModels = {
    'chat': 'gpt-4',
    'vision': 'gpt-4-vision',
    'embeddings': 'text-embedding-ada-002',
  };
}