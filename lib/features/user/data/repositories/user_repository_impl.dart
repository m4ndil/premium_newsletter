import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<UserEntity> getUserProfile() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    // Return dummy user data
    return const UserEntity(
      id: '1',
      name: 'Rajesh Hamal',
      dateOfBirth: 'January 15, 1888',
      photoUrl: 'https://english.artistkhabar.com/wp-content/uploads/2025/04/hamal.jpg',
      contact: '+(977) 9812345678',
      email: 'rajesh.hamal@hero.com.np',
      address: 'Chandol, Ktm',
      joinedYear: '2020',
      issuesRead: '50',
      designation: 'Software Engineer',
      organization: 'National College of Computer Studies',
      isActive: true,
      activeDaysRemaining: 125,
    );
  }

  @override
  Future<void> updateUserProfile(UserEntity user) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    // TODO: Implement update logic
  }
}