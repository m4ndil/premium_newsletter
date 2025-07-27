import '../entities/notice_entity.dart';
import '../repositories/notice_repository.dart';

class GetNoticesUseCase {
  final NoticeRepository repository;

  GetNoticesUseCase(this.repository);

  Future<List<NoticeEntity>> call() async {
    return await repository.getNotices();
  }
}
