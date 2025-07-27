import 'package:equatable/equatable.dart';

class NoticeEntity extends Equatable {
  final String id;
  final String title;
  final String message;
  final String date;
  final String priority;

  const NoticeEntity({
    required this.id,
    required this.title,
    required this.message,
    required this.date,
    required this.priority,
  });

  @override
  List<Object> get props => [id, title, message, date, priority];
}