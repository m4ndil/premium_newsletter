import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../bloc/newsletter_bloc.dart';
import '../../domain/entities/newsletter_entity.dart';

class NewsletterPage extends StatefulWidget {
  const NewsletterPage({super.key});

  @override
  State<NewsletterPage> createState() => _NewsletterPageState();
}

class _NewsletterPageState extends State<NewsletterPage> {
  @override
  void initState() {
    super.initState();
    context.read<NewsletterBloc>().add(GetNewslettersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsletterBloc, NewsletterState>(
      builder: (context, state) {
        if (state is NewsletterLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is NewsletterError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<NewsletterBloc>().add(GetNewslettersEvent());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is NewsletterLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<NewsletterBloc>().add(GetNewslettersEvent());
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.newsletters.length,
              itemBuilder: (context, index) {
                final newsletter = state.newsletters[index];
                return _buildNewsletterCard(context, newsletter);
              },
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildNewsletterCard(BuildContext context, NewsletterEntity newsletter) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          context.go('/newsletter/${newsletter.id}?url=${Uri.encodeComponent(newsletter.url)}');
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            if (newsletter.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: newsletter.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsletter.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        newsletter.date,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                  if (newsletter.description.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      newsletter.description,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
