import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/university.dart';
import '../providers/university_provider.dart';
import '../utils/theme.dart';
import '../widgets/main_drawer.dart';
import '../screens/university_list_screen.dart';
import '../models/application_step.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isNotificationPanelVisible = false;

  void _toggleNotificationPanel() {
    setState(() {
      _isNotificationPanelVisible = !_isNotificationPanelVisible;
    });
  }

  // Add sample notifications
  List<Map<String, dynamic>> _getSampleNotifications() {
    return [
      {
        'type': 'announcement',
        'title': 'New Universities Added',
        'message': '5 new universities have been added to our database',
        'time': DateTime.now().subtract(const Duration(hours: 2)),
        'icon': Icons.school,
        'color': Colors.blue,
      },
      {
        'type': 'reminder',
        'title': 'Application Tips',
        'message':
            'Remember to submit your documents early to avoid last-minute issues',
        'time': DateTime.now().subtract(const Duration(hours: 5)),
        'icon': Icons.lightbulb,
        'color': Colors.orange,
      },
      {
        'type': 'update',
        'title': 'Fee Structure Updated',
        'message':
            'University of Punjab has updated their fee structure for 2024',
        'time': DateTime.now().subtract(const Duration(days: 1)),
        'icon': Icons.update,
        'color': Colors.green,
      },
      {
        'type': 'alert',
        'title': 'Merit List Released',
        'message':
            'LUMS has released their first merit list. Check if you qualify!',
        'time': DateTime.now().subtract(const Duration(days: 2)),
        'icon': Icons.announcement,
        'color': Colors.red,
      },
      {
        'type': 'info',
        'title': 'Scholarship Opportunity',
        'message':
            'New scholarship programs available for engineering students',
        'time': DateTime.now().subtract(const Duration(days: 3)),
        'icon': Icons.star,
        'color': Colors.purple,
      },
    ];
  }

  @override
  void initState() {
    super.initState();
    // Fetch universities when the home screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<UniversityProvider>();
      provider.fetchUniversities();
      // Check for deadline reminders when app opens
      provider.checkDeadlineReminders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UNI-OPTION'),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            tooltip: 'Admin Panel',
            onPressed: () {
              Navigator.pushNamed(context, '/admin');
            },
          ),
        ],
      ),
      body: Consumer<UniversityProvider>(
        builder: (context, universityProvider, child) {
          if (universityProvider.isLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading universities...'),
                ],
              ),
            );
          }

          if (universityProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading data',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    universityProvider.error!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => universityProvider.fetchUniversities(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final topUniversities = universityProvider.getTopUniversities(6);
          final theme = Theme.of(context);

          return Scaffold(
            body: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 200,
                      pinned: true,
                      floating: false,
                      elevation: 0,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          'UNI-OPTION',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: theme.brightness == Brightness.light
                                ? Colors.white
                                : Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 5,
                                color: Colors.black.withValues(alpha: 0.3),
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.school_rounded,
                                size: 100,
                                color: Colors.white.withValues(alpha: 0.7),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppTheme.primaryColor
                                        .withValues(alpha: 0.4),
                                    AppTheme.primaryColor
                                        .withValues(alpha: 0.7),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 60,
                              left: 16,
                              right: 16,
                              child: Text(
                                'Your guide to Pakistani universities',
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 3,
                                      color:
                                          Colors.black.withValues(alpha: 0.3),
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            Navigator.pushNamed(context, '/universities');
                          },
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: _buildWelcomeSection(context),
                    ),
                    SliverToBoxAdapter(
                      child: _buildQuickActionsSection(context),
                    ),
                    SliverToBoxAdapter(
                      child: _buildNotificationSection(
                          context, universityProvider),
                    ),
                    SliverToBoxAdapter(
                      child: _buildFeaturedUniversitiesSection(
                          context, topUniversities),
                    ),
                    SliverToBoxAdapter(
                      child: _buildAppFeaturesSection(context),
                    ),
                  ],
                ),
                _buildNotificationPanel(context, universityProvider),
                _buildNotificationToggleButton(context),
              ],
            ),
            drawer: const MainDrawer(),
            floatingActionButton: OpenContainer(
              transitionDuration: const Duration(milliseconds: 500),
              openBuilder: (context, _) => const UniversityListScreen(),
              closedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              closedBuilder: (context, openContainer) => Container(
                width: 140,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor,
                      AppTheme.secondaryColor,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: openContainer,
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.school, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'Explore',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.9),
            theme.colorScheme.primary.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to UNI-OPTION',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your one-stop solution for university information, admission requirements, and application guidance in Pakistan.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/universities');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: theme.colorScheme.primary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
            child: const Text('Get Started'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 16),
            child: Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuickActionItem(
                context,
                Icons.school_rounded,
                'All Universities',
                () => Navigator.pushNamed(context, '/universities'),
                AppTheme.primaryColor,
              ),
              _buildQuickActionItem(
                context,
                Icons.favorite_rounded,
                'My Favorites',
                () => Navigator.pushNamed(context, '/favorites'),
                Colors.red,
              ),
              _buildQuickActionItem(
                context,
                Icons.settings_rounded,
                'Settings',
                () => Navigator.pushNamed(context, '/settings'),
                Colors.grey.shade700,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
    Color color,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: isDark ? 0.2 : 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationSection(
      BuildContext context, UniversityProvider universityProvider) {
    final deadlines = universityProvider.getUpcomingDeadlines();
    if (deadlines.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 16),
            child: Text(
              'Deadline Notifications',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: deadlines.length > 5 ? 5 : deadlines.length,
              itemBuilder: (context, index) {
                final item = deadlines[index];
                final University university = item['university'];
                final ApplicationStep step = item['step'];
                final int daysLeft = item['daysLeft'];
                final bool isPast = item['isPast'];

                Color cardColor = Theme.of(context).cardColor;
                Color textColor = Colors.red.shade600;
                String statusText;

                if (isPast) {
                  cardColor = Colors.grey.shade100;
                  textColor = Colors.grey.shade600;
                  statusText = '${daysLeft.abs()} days ago';
                } else if (daysLeft == 0) {
                  cardColor = Colors.red.shade50;
                  textColor = Colors.red.shade700;
                  statusText = 'Today!';
                } else if (daysLeft <= 3) {
                  cardColor = Colors.orange.shade50;
                  textColor = Colors.orange.shade700;
                  statusText = '$daysLeft days left';
                } else {
                  statusText = '$daysLeft days left';
                }

                return Container(
                  width: 200,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              university.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isPast)
                            Icon(Icons.history,
                                size: 16, color: Colors.grey.shade600)
                          else if (daysLeft <= 3)
                            Icon(Icons.warning,
                                size: 16, color: Colors.orange.shade700)
                          else
                            Icon(Icons.schedule,
                                size: 16, color: Colors.blue.shade600),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        step.title,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${DateFormat.yMMMd().format(step.deadline!)} ($statusText)',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: textColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggleButton(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      top: 100,
      right: _isNotificationPanelVisible ? 250 : 0,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _toggleNotificationPanel,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          child: Container(
            width: 40,
            height: 48,
            decoration: BoxDecoration(
              color: theme.cardColor.withValues(alpha: 0.8),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                )
              ],
            ),
            child: Icon(
              _isNotificationPanelVisible
                  ? Icons.arrow_forward_ios_rounded
                  : Icons.notifications,
              color: theme.colorScheme.primary,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationPanel(
      BuildContext context, UniversityProvider universityProvider) {
    final theme = Theme.of(context);
    final deadlines = universityProvider.getUpcomingDeadlines();
    final notifications = _getSampleNotifications();
    final panelWidth = 250.0;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      top: 0,
      bottom: 0,
      right: _isNotificationPanelVisible ? 0 : -panelWidth,
      child: Material(
        elevation: 16,
        child: Container(
          width: panelWidth,
          height: double.infinity,
          color: theme.scaffoldBackgroundColor,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'Notifications',
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(indent: 16, endIndent: 16),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    children: [
                      // Deadline notifications section
                      if (deadlines.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                          child: Text(
                            'Upcoming Deadlines',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                        ...deadlines.map((item) {
                          final University university = item['university'];
                          final ApplicationStep step = item['step'];
                          final daysLeft =
                              step.deadline!.difference(DateTime.now()).inDays;

                          return Card(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.red.withOpacity(0.1),
                                child: Icon(
                                  Icons.schedule,
                                  color: Colors.red.shade600,
                                  size: 16,
                                ),
                              ),
                              title: Text(
                                university.name,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    step.title,
                                    style: theme.textTheme.bodySmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '$daysLeft days left',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                        color: Colors.red.shade600,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/university-detail',
                                  arguments: university,
                                );
                              },
                            ),
                          );
                        }),
                        const SizedBox(height: 16),
                      ],

                      // General notifications section
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Text(
                          'Recent Updates',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      ...notifications.map((notification) {
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: (notification['color'] as Color)
                                  .withOpacity(0.1),
                              child: Icon(
                                notification['icon'] as IconData,
                                color: notification['color'] as Color,
                                size: 16,
                              ),
                            ),
                            title: Text(
                              notification['title'] as String,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  notification['message'] as String,
                                  style: theme.textTheme.bodySmall,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _getTimeAgo(notification['time'] as DateTime),
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              // Handle notification tap
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text(notification['message'] as String),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  Widget _buildFeaturedUniversitiesSection(
      BuildContext context, List<University> universities) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Featured Universities',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/universities');
                  },
                  child: Text(
                    'See All',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: universities.length,
              itemBuilder: (context, index) {
                final university = universities[index];
                return _buildFeaturedUniversityCard(context, university);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedUniversityCard(
      BuildContext context, University university) {
    final theme = Theme.of(context);

    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.cardTheme.color,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/university-detail',
              arguments: university,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 120,
                    width: double.infinity,
                    child: Image.asset(
                      university.imageUrl.isNotEmpty
                          ? university.imageUrl
                          : 'assets/images/university1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.6),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.universityAccent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        university.type,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      university.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: theme.colorScheme.secondary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            university.location,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.7),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${university.programs.length} Programs Available',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppFeaturesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 16, top: 8),
            child: Text(
              'App Features',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          _buildFeatureCard(
            context,
            Icons.school_rounded,
            'Comprehensive University Database',
            'Access detailed information about universities across Lahore.',
            Colors.indigo,
          ),
          _buildFeatureCard(
            context,
            Icons.description_rounded,
            'Admission Requirements',
            'Understand eligibility criteria and application processes for different universities.',
            Colors.teal,
          ),
          _buildFeatureCard(
            context,
            Icons.map_rounded,
            'Maps',
            'View university locations through interactive maps.',
            Colors.amber.shade800,
          ),
          _buildFeatureCard(
            context,
            Icons.bookmark_rounded,
            'Save',
            'Bookmark your favorite universities for easy access later.',
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    Color iconColor,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 8, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 28,
            color: iconColor,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
