import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:premium_newsletter/features/auth/domain/entities/user_credentials.dart';
import 'package:premium_newsletter/features/auth/domain/usecase/login_usecase.dart';
import 'package:premium_newsletter/features/auth/domain/usecase/logout_usecase.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class LogoutRequested extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      final credentials = UserCredentials(
        email: event.email,
        password: event.password,
      );

      final success = await loginUseCase(credentials);

      if (success) {
        emit(AuthSuccess());
      } else {
        emit(const AuthFailure('Invalid email or password'));
      }
    } catch (e) {
      emit(AuthFailure('Login failed: ${e.toString()}'));
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event,
      Emitter<AuthState> emit,
      ) async {
    try {
      await logoutUseCase();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure('Logout failed: ${e.toString()}'));
    }
  }
}