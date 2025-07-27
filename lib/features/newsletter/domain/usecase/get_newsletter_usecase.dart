import '../entities/newsletter_entity.dart';
import '../repositories/newsletter_repository.dart';

class GetNewslettersUseCase {
  final NewsletterRepository repository;

  GetNewslettersUseCase(this.repository);

  Future<List<NewsletterEntity>> call() async {
    return await repository.getNewsletters();
  }
}