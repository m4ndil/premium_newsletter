import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final int age;
  final String dateOfBirth;
  final String photoUrl;
  final String contact;
  final String address;
  final bool isActive;
  final int activeDaysRemaining;

  const UserEntity({
    required this.id,
    required this.name,
    required this.age,
    required this.dateOfBirth,
    required this.photoUrl,
    required this.contact,
    required this.address,
    required this.isActive,
    required this.activeDaysRemaining,
  });

  @override
  List<Object> get props => [
    id,
    name,
    age,
    dateOfBirth,
    photoUrl,
    contact,
    address,
    isActive,
    activeDaysRemaining,
  ];
}
