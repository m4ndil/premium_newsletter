import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String dateOfBirth;
  final String photoUrl;
  final String contact;
  final String email;
  final String address;
  final String joinedYear;
  final String issuesRead;
  final String designation;
  final String organization;
  final bool isActive;
  final int activeDaysRemaining;

  const UserEntity({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.photoUrl,
    required this.contact,
    required this.email,
    required this.address,
    required this.joinedYear,
    required this.issuesRead,
    required this.designation,
    required this.organization,
    required this.isActive,
    required this.activeDaysRemaining,
  });

  @override
  List<Object> get props => [
    id,
    name,
    dateOfBirth,
    photoUrl,
    contact,
    address,
    joinedYear,
    issuesRead,
    designation,
    organization,
    isActive,
    activeDaysRemaining,
  ];
}
