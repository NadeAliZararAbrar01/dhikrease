/*import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/theme_provider.dart';
import 'announcement_screen.dart';
import 'azkar_screen.dart';
import 'dua_screen.dart';
import 'favorites_screen.dart';
import 'setting_screens.dart';
import 'tasbeeh_counter_screen.dart';
import 'names_of_allah.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  bool get _firebaseAvailable =>
      kIsWeb || Platform.isAndroid || Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    final List<Widget> screens = [
      _homePage(context, isDark),
      _azkarMenuPage(context),
      const FavoritesScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: const Text(
          'DhikrEase',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.themeMode == ThemeMode.light
                  ? Icons.nights_stay
                  : Icons.wb_sunny,
              color: Colors.white,
            ),
            onPressed: () => themeProvider.toggleTheme(),
          ),
          if (_firebaseAvailable)
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              tooltip: 'Logout',
              onPressed: _logout,
            ),
        ],
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.teal[700],
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book), label: 'Azkar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('Logout', style: TextStyle(color: Colors.red.shade600)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
              (_) => false,
        );
      }
    }
  }

  Widget _homePage(BuildContext context, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting
          _buildGreetingCard(isDark),
          const SizedBox(height: 24),
          Text(
            'Quick Access',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              print("TEST BUTTON WORKING");
            },
            child: const Text("Test"),
          ),
          // Morning & Evening Azkar
          Row(
            children: [
              Expanded(
                child: _quickButton(
                  context,
                  icon: Icons.wb_sunny,
                  label: 'Morning\nAzkar',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AzkarScreen(type: 'Morning'),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _quickButton(
                  context,
                  icon: Icons.nights_stay,
                  label: 'Evening\nAzkar',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AzkarScreen(type: 'Evening'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Dua Library & 99 Names
          Row(
            children: [
              Expanded(
                child: _quickButton(
                  context,
                  icon: Icons.menu_book,
                  label: 'Dua\nLibrary',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DuaScreen()),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _quickButton(
                  context,
                  icon: Icons.auto_awesome,
                  label: '99 Names\nof Allah',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NamesOfAllahScreen(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: _quickButton(
              context,
              icon: Icons.announcement,
              label: 'Announcements',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AnnouncementScreen()),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Tasbeeh Counter — full width
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.format_list_numbered),
              label: const Text(
                'Tasbeeh Counter',
                style: TextStyle(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TasbeehCounterScreen(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingCard(bool isDark) {
    String? displayName;
    if (_firebaseAvailable) {
      displayName = FirebaseAuth.instance.currentUser?.displayName;
    }
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.green.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              displayName != null && displayName.isNotEmpty
                  ? 'Welcome back, $displayName 👋'
                  : 'Welcome Back 👋',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              '"A good word is charity."',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '— Prophet Muhammad ﷺ',
                style: TextStyle(fontSize: 13, color: Colors.green.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onTap,
      }) {
    return SizedBox(
      height: 70,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 13),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal[700],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onTap,
      ),
    );
  }

  Widget _azkarMenuPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          _azkarMenuButton(
            context,
            icon: Icons.wb_sunny,
            label: 'Morning Azkar',
            type: 'Morning',
          ),
          const SizedBox(height: 20),
          _azkarMenuButton(
            context,
            icon: Icons.nights_stay,
            label: 'Evening Azkar',
            type: 'Evening',
          ),
        ],
      ),
    );
  }

  Widget _azkarMenuButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String type,
      }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(label, style: const TextStyle(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal[700],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AzkarScreen(type: type)),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'habbit_provider.dart';
import 'tasbeeh_counter_screen.dart';
import 'dua_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final habit = context.watch<HabitProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DhikrEase',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal[700],
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Welcome to DhikrEase 👋',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Make time for dhikr and daily duas.',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Daily Azkar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Morning count
            _countCard(
              title: 'Morning Azkar',
              count: habit.morningAzkarCount,
              icon: Icons.wb_sunny,
              onPressed: () {
                context.read<HabitProvider>().incrementMorning();
              },
            ),

            const SizedBox(height: 10),

            // Evening count
            _countCard(
              title: 'Evening Azkar',
              count: habit.eveningAzkarCount,
              icon: Icons.nights_stay,
              onPressed: () {
                context.read<HabitProvider>().incrementEvening();
              },
            ),

            const SizedBox(height: 12),

            Text(
              'Total Azkar count: ${habit.total}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Quick Access',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Open Tasbeeh Counter
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.touch_app),
                label: const Text('Tasbeeh Counter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                      const TasbeehCounterScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // Open Dua Library
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.menu_book),
                label: const Text('Dua Library'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DuaScreen(),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Reset daily counts
            OutlinedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Reset Azkar Counts'),
              onPressed: () {
                context.read<HabitProvider>().resetCounts();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Reusable card for each Azkar counter
  Widget _countCard({
    required String title,
    required int count,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.teal[700],
          size: 30,
        ),
        title: Text(title),
        subtitle: Text('Count: $count'),
        trailing: IconButton(
          icon: const Icon(Icons.add_circle),
          color: Colors.teal[700],
          tooltip: 'Increase count',
          onPressed: onPressed,
        ),
      ),
    );
  }
}
