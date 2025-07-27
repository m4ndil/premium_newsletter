import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:premium_newsletter/features/notices/domain/usecase/get_notices_usecase.dart';
import '../../domain/entities/notice_entity.dart';

// Events
abstract class NoticeEvent extends Equatable {
  const NoticeEvent();

  @override
  List<Object> get props => [];
}

class GetNoticesEvent extends NoticeEvent {}

// States
abstract class NoticeState extends Equatable {
  const NoticeState();

  @override
  List<Object> get props => [];
}

class NoticeInitial extends NoticeState {}

class NoticeLoading extends NoticeState {}

class NoticeLoaded extends NoticeState {
  final List<NoticeEntity> notices;

  const NoticeLoaded(this.notices);

  @override
  List<Object> get props => [notices];
}

class NoticeError extends NoticeState {
  final String message;

  const NoticeError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  final GetNoticesUseCase getNoticesUseCase;

  NoticeBloc(this.getNoticesUseCase) : super(NoticeInitial()) {
    on<GetNoticesEvent>(_onGetNotices);
  }

  Future<void> _onGetNotices(
      GetNoticesEvent event,
      Emitter<NoticeState> emit,
      ) async {
    emit(NoticeLoading());

    try {
      final notices = await getNoticesUseCase();
      emit(NoticeLoaded(notices));
    } catch (e) {
      emit(NoticeError('Failed to load notices: ${e.toString()}'));
    }
  }
}
