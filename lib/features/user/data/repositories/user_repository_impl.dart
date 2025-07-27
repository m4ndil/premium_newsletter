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
      name: 'John Doe',
      age: 28,
      dateOfBirth: 'January 15, 1995',
      photoUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400',
      contact: '+1 (555) 123-4567',
      address: '123 Main Street, New York, NY 10001',
      isActive: true,
      activeDaysRemaining: 25,
    );
  }

  @override
  Future<void> updateUserProfile(UserEntity user) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    // TODO: Implement update logic
  }
}