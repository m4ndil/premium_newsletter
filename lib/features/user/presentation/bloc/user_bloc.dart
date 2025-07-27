import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_newsletter/features/user/domain/usecase/get_user_profile_usecase.dart';
import '../../domain/entities/user_entity.dart';

// Events
abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserProfileEvent extends UserEvent {}

// States
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserEntity user;

  const UserLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserProfileUseCase getUserProfileUseCase;

  UserBloc(this.getUserProfileUseCase) : super(UserInitial()) {
    on<GetUserProfileEvent>(_onGetUserProfile);
  }

  Future<void> _onGetUserProfile(
      GetUserProfileEvent event,
      Emitter<UserState> emit,
      ) async {
    emit(UserLoading());

    try {
      final user = await getUserProfileUseCase();
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError('Failed to load user profile: ${e.toString()}'));
    }
  }
}
