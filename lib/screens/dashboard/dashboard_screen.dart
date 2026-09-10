import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/login_screen.dart';

import '../posts/posts_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<String> _titles = [
    'Home',
    'Posts',
    'Notice',
    'Profile',
    'Settings',
  ];

  // =========================
  // LOGOUT
  // =========================

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(title: Text(_titles[_currentIndex]), centerTitle: false),

      // =========================
      // BODY
      // =========================
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHome(),
          // _buildPosts(),
          const PostsScreen(),
          _buildNotice(),
          _buildProfile(),
          _buildSettings(),
        ],
      ),

      // =========================
      // BOTTOM NAVIGATION
      // =========================
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,

        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(Icons.article_outlined),
            selectedIcon: Icon(Icons.article),
            label: 'Posts',
          ),

          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: 'Notice',
          ),

          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),

          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HOME
  // ============================================================

  Widget _buildHome() {
    final user = FirebaseAuth.instance.currentUser;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // Welcome
          Text(
            'Welcome back! 👋',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          // Email
          Text(
            user?.email ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 25),

          // =========================
          // QUICK ACCESS
          // =========================
          const Text(
            'Quick Access',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,

            physics: const NeverScrollableScrollPhysics(),

            crossAxisSpacing: 12,
            mainAxisSpacing: 12,

            children: [
              // Posts
              _quickCard(
                icon: Icons.article,
                title: 'Posts',
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),

              // Notices
              _quickCard(
                icon: Icons.notifications,
                title: 'Notices',
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),

              // Profile
              _quickCard(
                icon: Icons.person,
                title: 'My Profile',
                onTap: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
              ),

              // Settings
              _quickCard(
                icon: Icons.settings,
                title: 'Settings',
                onTap: () {
                  setState(() {
                    _currentIndex = 4;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 30),

          // =========================
          // LATEST UPDATES
          // =========================
          const Text(
            'Latest Updates',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 15),

          _updateCard(
            Icons.campaign,
            'Welcome to EdTE-UFTB',
            'Department updates will appear here.',
          ),

          _updateCard(
            Icons.school,
            'Academic Information',
            'Stay connected with your department.',
          ),
        ],
      ),
    );
  }

  // ============================================================
  // POSTS
  // ============================================================

  // Widget _buildPosts() {
  //   return const Center(
  //     child: Text(
  //       'Posts\n\nPost system coming next 🚀',
  //       textAlign: TextAlign.center,
  //       style: TextStyle(fontSize: 20),
  //     ),
  //   );
  // }

  // ============================================================
  // NOTICE
  // ============================================================

  Widget _buildNotice() {
    return const Center(
      child: Text(
        'Department Notices\n\nNotices will appear here.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  // ============================================================
  // PROFILE
  // ============================================================

  Widget _buildProfile() {
    final user = FirebaseAuth.instance.currentUser;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),

      child: Column(
        children: [
          const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 55)),

          const SizedBox(height: 20),

          const Text(
            'Student Profile',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 25),

          // Email
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email'),
            subtitle: Text(user?.email ?? 'Not available'),
          ),

          const Divider(),

          // Student ID
          const ListTile(
            leading: Icon(Icons.badge),
            title: Text('Student ID'),
            subtitle: Text('Will load from Firestore'),
          ),

          const Divider(),

          // Full Name
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('Full Name'),
            subtitle: Text('Will load from Firestore'),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SETTINGS
  // ============================================================

  Widget _buildSettings() {
    return ListView(
      padding: const EdgeInsets.all(16),

      children: [
        const ListTile(
          leading: Icon(Icons.notifications),
          title: Text('Notifications'),
          subtitle: Text('Manage notifications'),
          trailing: Icon(Icons.chevron_right),
        ),

        const Divider(),

        const ListTile(
          leading: Icon(Icons.lock),
          title: Text('Change Password'),
          subtitle: Text('Update your account password'),
          trailing: Icon(Icons.chevron_right),
        ),

        const Divider(),

        const ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('About EdTE-UFTB'),
          subtitle: Text('Department information'),
          trailing: Icon(Icons.chevron_right),
        ),

        const Divider(),

        // Logout
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),

          title: const Text('Logout', style: TextStyle(color: Colors.red)),

          onTap: _logout,
        ),
      ],
    );
  }

  // ============================================================
  // QUICK CARD
  // ============================================================

  Widget _quickCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),

        onTap: onTap,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(icon, size: 40),

            const SizedBox(height: 10),

            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // UPDATE CARD
  // ============================================================

  Widget _updateCard(IconData icon, String title, String subtitle) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),

        title: Text(title),

        subtitle: Text(subtitle),
      ),
    );
  }
}
