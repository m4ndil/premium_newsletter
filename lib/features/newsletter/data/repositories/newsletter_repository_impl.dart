import '../../domain/entities/newsletter_entity.dart';
import '../../domain/repositories/newsletter_repository.dart';

class NewsletterRepositoryImpl implements NewsletterRepository {
  @override
  Future<List<NewsletterEntity>> getNewsletters() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    // Return dummy newsletter data
    return const [
      NewsletterEntity(
        id: '1',
        title: 'Welcome to Our Newsletter',
        description: 'Introduction to our monthly newsletter with updates and insights.',
        date: 'July 25, 2025',
        imageUrl: 'https://images.unsplash.com/photo-1586953208448-b95a79798f07?w=400',
        url: 'https://flutter.dev',
      ),
      NewsletterEntity(
        id: '2',
        title: 'Tech Updates and Innovations',
        description: 'Latest technology trends and innovations in the mobile app development world.',
        date: 'July 20, 2025',
        imageUrl: 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=400',
        url: 'https://flutter.dev/docs',
      ),
      NewsletterEntity(
        id: '3',
        title: 'Flutter 4.0 Release Notes',
        description: 'Comprehensive overview of new features and improvements in Flutter 4.0.',
        date: 'July 15, 2025',
        imageUrl: 'https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=400',
        url: 'https://docs.flutter.dev',
      ),
      NewsletterEntity(
        id: '4',
        title: 'Mobile App Security Best Practices',
        description: 'Essential security practices every mobile app developer should follow.',
        date: 'July 10, 2025',
        imageUrl: 'https://images.unsplash.com/photo-1563013544-824ae1b704d3?w=400',
        url: 'https://flutter.dev/security',
      ),
    ];
  }
}
