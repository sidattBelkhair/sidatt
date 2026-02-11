// widgets/admin/admin_dashboard.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/admin_provider.dart';
import '../responsive/responsive_layout.dart';
import 'admin_tabs/projects_tab.dart';
import 'admin_tabs/skills_tab.dart';
import 'admin_tabs/experience_tab.dart';
import 'admin_tabs/contact_tab.dart';
import 'admin_tabs/themes_tab.dart';
import 'admin_tabs/settings_tab.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: _buildMobileLayout(),
      tabletBody: _buildTabletLayout(),
      desktopBody: _buildDesktopLayout(),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio Admin'),
        backgroundColor: const Color(0xFF0a0a0a),
        elevation: 0,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text('Logout'),
                onTap: () {
                  context.read<AdminProvider>().logoutAdmin();
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                },
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: const Color(0xFF00ff41),
              labelColor: const Color(0xFF00ff41),
              unselectedLabelColor: Colors.white54,
              tabs: const [
                Tab(text: 'Projects'),
                Tab(text: 'Skills'),
                Tab(text: 'Experience'),
                Tab(text: 'Contact'),
                Tab(text: 'Themes'),
                Tab(text: 'Settings'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ProjectsTab(),
                SkillsTab(),
                ExperienceTab(),
                ContactTab(),
                ThemesTab(),
                SettingsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio Admin Panel'),
        backgroundColor: const Color(0xFF0a0a0a),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<AdminProvider>().logoutAdmin();
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: false,
            indicatorColor: const Color(0xFF00ff41),
            labelColor: const Color(0xFF00ff41),
            unselectedLabelColor: Colors.white54,
            tabs: const [
              Tab(icon: Icon(Icons.folder), text: 'Projects'),
              Tab(icon: Icon(Icons.school), text: 'Skills'),
              Tab(icon: Icon(Icons.work), text: 'Experience'),
              Tab(icon: Icon(Icons.contact_mail), text: 'Contact'),
              Tab(icon: Icon(Icons.palette), text: 'Themes'),
              Tab(icon: Icon(Icons.settings), text: 'Settings'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ProjectsTab(),
                SkillsTab(),
                ExperienceTab(),
                ContactTab(),
                ThemesTab(),
                SettingsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio Admin Panel'),
        backgroundColor: const Color(0xFF0a0a0a),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF00ff41),
          labelColor: const Color(0xFF00ff41),
          unselectedLabelColor: Colors.white54,
          tabs: const [
            Tab(icon: Icon(Icons.folder), text: 'Projects'),
            Tab(icon: Icon(Icons.school), text: 'Skills'),
            Tab(icon: Icon(Icons.work), text: 'Experience'),
            Tab(icon: Icon(Icons.contact_mail), text: 'Contact'),
            Tab(icon: Icon(Icons.palette), text: 'Themes'),
            Tab(icon: Icon(Icons.settings), text: 'Settings'),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                context.read<AdminProvider>().logoutAdmin();
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ProjectsTab(),
          SkillsTab(),
          ExperienceTab(),
          ContactTab(),
          ThemesTab(),
          SettingsTab(),
        ],
      ),
    );
  }
}
