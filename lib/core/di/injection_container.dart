import 'package:dio/dio.dart';
import 'package:premium_newsletter/features/auth/domain/usecase/login_usecase.dart';
import 'package:premium_newsletter/features/auth/domain/usecase/logout_usecase.dart';
import 'package:premium_newsletter/features/newsletter/domain/usecase/get_newsletter_usecase.dart';
import 'package:premium_newsletter/features/notices/domain/usecase/get_notices_usecase.dart';
import 'package:premium_newsletter/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:premium_newsletter/features/user/domain/usecase/get_user_profile_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:premium_newsletter/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:premium_newsletter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:premium_newsletter/features/auth/domain/repositories/auth_repository.dart';
import 'package:premium_newsletter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:premium_newsletter/features/user/data/repositories/user_repository_impl.dart';
import 'package:premium_newsletter/features/user/domain/repositories/user_repository.dart';
import 'package:premium_newsletter/features/user/presentation/bloc/user_bloc.dart';
import 'package:premium_newsletter/features/newsletter/data/repositories/newsletter_repository_impl.dart';
import 'package:premium_newsletter/features/newsletter/domain/repositories/newsletter_repository.dart';
import 'package:premium_newsletter/features/newsletter/presentation/bloc/newsletter_bloc.dart';
import 'package:premium_newsletter/features/notices/data/repositories/notice_repository_impl.dart';
import 'package:premium_newsletter/features/notices/domain/repositories/notice_repository.dart';
import 'package:premium_newsletter/features/notices/presentation/bloc/notice_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  final dio = Dio();

  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => dio);

  // Data sources
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(getIt()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  getIt.registerLazySingleton<NewsletterRepository>(
    () => NewsletterRepositoryImpl(),
  );
  getIt.registerLazySingleton<NoticeRepository>(() => NoticeRepositoryImpl());

  // Use cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt()));
  getIt.registerLazySingleton(() => GetUserProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => GetNewslettersUseCase(getIt()));
  getIt.registerLazySingleton(() => GetNoticesUseCase(getIt()));

  // BLoCs
  getIt.registerFactory(
    () => AuthBloc(loginUseCase: getIt(), logoutUseCase: getIt()),
  );
  getIt.registerFactory(() => UserBloc(getIt()));
  getIt.registerFactory(() => NewsletterBloc(getIt()));
  getIt.registerFactory(() => NoticeBloc(getIt()));
  getIt.registerFactory<ThemeBloc>(() => ThemeBloc());

}
