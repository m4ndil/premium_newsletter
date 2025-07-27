import '../../domain/entities/notice_entity.dart';
import '../../domain/repositories/notice_repository.dart';

class NoticeRepositoryImpl implements NoticeRepository {
  @override
  Future<List<NoticeEntity>> getNotices() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    // Return dummy notice data
    return const [
      NoticeEntity(
        id: '1',
        title: 'System Maintenance',
        message: 'The system will be under maintenance on July 30th from 2:00 AM to 4:00 AM UTC. Please save your work before this time.',
        date: 'July 27, 2025',
        priority: 'high',
      ),
      NoticeEntity(
        id: '2',
        title: 'New Feature Available',
        message: 'We have added a new dark mode feature to the app. You can enable it from the settings menu.',
        date: 'July 25, 2025',
        priority: 'medium',
      ),
      NoticeEntity(
        id: '3',
        title: 'Holiday Schedule',
        message: 'Our support team will have limited availability during the upcoming holidays. Response times may be longer than usual.',
        date: 'July 22, 2025',
        priority: 'low',
      ),
      NoticeEntity(
        id: '4',
        title: 'Security Update',
        message: 'Please update your app to the latest version to ensure you have the latest security improvements.',
        date: 'July 20, 2025',
        priority: 'high',
      ),
      NoticeEntity(
        id: '5',
        title: 'Newsletter Subscription',
        message: 'Don\'t forget to subscribe to our newsletter to stay updated with the latest news and features.',
        date: 'July 18, 2025',
        priority: 'low',
      ),
    ];
  }
}
