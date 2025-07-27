import '../entities/newsletter_entity.dart';

abstract class NewsletterRepository {
  Future<List<NewsletterEntity>> getNewsletters();
}