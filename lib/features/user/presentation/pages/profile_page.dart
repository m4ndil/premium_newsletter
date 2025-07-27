import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/user_bloc.dart';
import '../../domain/entities/user_entity.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is UserError) {
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
              ],
            ),
          );
        }

        if (state is UserLoaded) {
          return _buildProfileContent(context, state.user);
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildProfileContent(BuildContext context, UserEntity user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: user.photoUrl.isNotEmpty
                      ? CachedNetworkImageProvider(user.photoUrl)
                      : null,
                  child: user.photoUrl.isEmpty
                      ? Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey[400],
                  )
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: user.isActive
                        ? Colors.green.shade100
                        : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    user.isActive ? 'Active' : 'Inactive',
                    style: TextStyle(
                      color: user.isActive
                          ? Colors.green.shade800
                          : Colors.red.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // User Information Cards
          _buildInfoCard(
            context,
            'Personal Information',
            [
              _buildInfoRow(Icons.cake, 'Age', '${user.age} years'),
              _buildInfoRow(Icons.calendar_today, 'Date of Birth', user.dateOfBirth),
              _buildInfoRow(Icons.phone, 'Contact', user.contact),
              _buildInfoRow(Icons.location_on, 'Address', user.address),
            ],
          ),

          const SizedBox(height: 16),

          // Membership Information
          _buildInfoCard(
            context,
            'Membership Status',
            [
              _buildInfoRow(
                Icons.card_membership,
                'Status',
                user.isActive ? 'Active' : 'Inactive',
                valueColor: user.isActive ? Colors.green : Colors.red,
              ),
              if (user.isActive)
                _buildInfoRow(
                  Icons.schedule,
                  'Days Remaining',
                  '${user.activeDaysRemaining} days',
                ),
            ],
          ),

          const SizedBox(height: 24),

          // Renewal Button (if inactive)
          if (!user.isActive)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  _showRenewalDialog(context);
                },
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'Renew Membership',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRenewalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Renew Membership'),
        content: const Text(
          'Would you like to renew your membership? This will extend your access for another 30 days.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement renewal logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Membership renewal initiated!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Renew'),
          ),
        ],
      ),
    );
  }
}