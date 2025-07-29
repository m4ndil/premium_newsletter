import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
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
          return const Center(child: CircularProgressIndicator());
        }

        if (state is UserError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
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
                // Avatar
                CircleAvatar(
                  radius: 56,
                  backgroundColor: Colors.grey.shade100,
                  backgroundImage:
                      user.photoUrl.isNotEmpty
                          ? CachedNetworkImageProvider(user.photoUrl)
                          : null,
                  child:
                      user.photoUrl.isEmpty
                          ? Icon(
                            Icons.person_outline,
                            size: 48,
                            color: Colors.grey.shade400,
                          )
                          : null,
                ),
                const SizedBox(height: 20),
                // Name
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 6),
                // Office
                Text(
                  user.designation,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
                // Office
                Text(
                  user.organization,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 12),
                // Birthday & Location
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Birthday
                    Row(
                      children: [
                        Icon(Icons.cake_outlined, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          user.dateOfBirth,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    // Location
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          user.address,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  child: Icon(Icons.more_horiz_rounded, size: 22),
                  onTap: () {
                    _showMoreDialog(context, user.contact, user.email);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                _buildStatsCard('Joined', user.joinedYear),
                const SizedBox(width: 12),
                _buildStatsCard('Issues Read', user.issuesRead),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Card(
                    color:
                        Theme.of(context).brightness == Brightness.light
                            ? Colors
                                .grey
                                .shade50 // Light mode color
                            : Theme.of(context).cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  user.isActive
                                      ? Colors.green.shade50
                                      : Colors.red.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color:
                                    user.isActive
                                        ? Colors.green.shade100
                                        : Colors.red.shade100,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              (user.isActive ? 'Active' : 'Inactive')
                                  .toUpperCase(),
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge?.copyWith(
                                color:
                                    user.isActive
                                        ? Colors.green.shade800
                                        : Colors.red.shade800,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          buildIndicator(user.activeDaysRemaining),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    SizedBox(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (user.isActive) {
                            _showRenewalDialog(context);
                          } else {
                            _showRenewalDialog(context);
                          }
                        },
                        icon: const Icon(Icons.refresh),
                        label: Text(
                          user.isActive ? 'Pay Advance' : 'Renew Membership',
                          style: const TextStyle(
                            fontSize: 11,
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

                    SizedBox(height: 10),
                    SizedBox(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _showRenewalDialog(context);
                        },
                        icon: const Icon(Icons.history),
                        label: const Text(
                          'Member Log',
                          style: TextStyle(
                            fontSize: 11,
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
              ),
            ],
          ),
          // Renewal Button (if inactive)
        ],
      ),
    );
  }

  Widget buildIndicator(int days) {
    final double percent = days.clamp(0, 365) / 365;
    final Color progressColor = days <= 10 ? Colors.red : Colors.green;

    return CircularPercentIndicator(
      radius: 60.0,
      lineWidth: 10.0,
      percent: percent,
      animation: true,
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: progressColor,
      backgroundColor:
          Theme.of(context).brightness == Brightness.light
              ? Colors
                  .grey
                  .shade300 // Light mode background
              : Colors.grey.shade400, // Dark mode background
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$days',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            'Days Left'.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color:
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade700
                      : Colors.grey.shade200,
              fontSize: 11,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(String title, String value) {
    return Expanded(
      child: Card(
        color:
            Theme.of(context).brightness == Brightness.light
                ? Colors
                    .grey
                    .shade50 // Light mode color
                : Theme.of(context).cardColor,
        elevation: 0.4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color:
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.grey.shade700
                          : Colors.grey.shade200,
                  fontSize: 11,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMoreDialog(BuildContext context, String contact, String email) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Theme.of(context).dialogBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.call,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      contact,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Theme.of(context).dividerColor,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.mail,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  void _showRenewalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
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
