import 'package:equatable/equatable.dart';

class NewsletterEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String date;
  final String imageUrl;
  final String url;

  const NewsletterEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.imageUrl,
    required this.url,
  });

  @override
  List<Object> get props => [id, title, description, date, imageUrl, url];
}