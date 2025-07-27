import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class GetUserProfileUseCase {
  final UserRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<UserEntity> call() async {
    return await repository.getUserProfile();
  }
}