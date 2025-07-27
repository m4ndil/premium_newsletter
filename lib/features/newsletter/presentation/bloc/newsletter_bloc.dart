import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:premium_newsletter/features/newsletter/domain/usecase/get_newsletter_usecase.dart';
import '../../domain/entities/newsletter_entity.dart';

// Events
abstract class NewsletterEvent extends Equatable {
  const NewsletterEvent();

  @override
  List<Object> get props => [];
}

class GetNewslettersEvent extends NewsletterEvent {}

// States
abstract class NewsletterState extends Equatable {
  const NewsletterState();

  @override
  List<Object> get props => [];
}

class NewsletterInitial extends NewsletterState {}

class NewsletterLoading extends NewsletterState {}

class NewsletterLoaded extends NewsletterState {
  final List<NewsletterEntity> newsletters;

  const NewsletterLoaded(this.newsletters);

  @override
  List<Object> get props => [newsletters];
}

class NewsletterError extends NewsletterState {
  final String message;

  const NewsletterError(this.message);

  @override
  List<Object> get props => [message];
}

// BLoC
class NewsletterBloc extends Bloc<NewsletterEvent, NewsletterState> {
  final GetNewslettersUseCase getNewslettersUseCase;

  NewsletterBloc(this.getNewslettersUseCase) : super(NewsletterInitial()) {
    on<GetNewslettersEvent>(_onGetNewsletters);
  }

  Future<void> _onGetNewsletters(
      GetNewslettersEvent event,
      Emitter<NewsletterState> emit,
      ) async {
    emit(NewsletterLoading());

    try {
      final newsletters = await getNewslettersUseCase();
      emit(NewsletterLoaded(newsletters));
    } catch (e) {
      emit(NewsletterError('Failed to load newsletters: ${e.toString()}'));
    }
  }
}
