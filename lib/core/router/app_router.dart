import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/home/presentation/pages/main_page.dart';
import '../../features/newsletter/presentation/pages/newsletter_detail_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/main',
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: '/newsletter/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final url = state.uri.queryParameters['url'] ?? '';
          return NewsletterDetailPage(id: id, url: url);
        },
      ),
    ],
  );
}