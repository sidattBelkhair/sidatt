// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/terminal_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _scrollToSection(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutQuart,
    );
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        onNavigate: _scrollToSection,
        scrollController: _scrollController,
      ),
      endDrawer: _buildMobileMenu(langProvider, themeProvider, size),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0a0a0a),
              const Color(0xFF0f1419),
              const Color(0xFF0a0a0a),
            ],
          ),
        ),
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              HeroSection(
                animationController: _animationController,
                onScrollToTerminal: () => _scrollToSection(size.height * 3.5),
              ),
              const SkillsSection(),
              const ProjectsSection(),
              const ExperienceSection(),
              const TerminalSection(),
              const ContactSection(),
              const Footer(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOutQuart,
          );
        },
        backgroundColor: const Color(0xFF00ff41),
        child: const Icon(Icons.arrow_upward, color: Colors.black),
      ),
    );
  }

  Widget _buildMobileMenu(LanguageProvider langProvider, ThemeProvider themeProvider, Size size) {
    return Drawer(
      backgroundColor: const Color(0xFF0a0a0a),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF1a1a1a),
              border: Border(
                bottom: BorderSide(color: Color(0xFF00ff41), width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.terminal,
                  color: Color(0xFF00ff41),
                  size: 32,
                ),
                const SizedBox(height: 12),
                const Text(
                  'sidatt@portfolio',
                  style: TextStyle(
                    color: Color(0xFF00ff41),
                    fontFamily: 'JetBrains Mono',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            Icons.home,
            langProvider.getTranslation('about'),
            () {
              Navigator.pop(context);
              _scrollToSection(size.height * 0.8);
            },
          ),
          _buildDrawerItem(
            context,
            Icons.code,
            langProvider.getTranslation('skills'),
            () {
              Navigator.pop(context);
              _scrollToSection(size.height * 1.8);
            },
          ),
          _buildDrawerItem(
            context,
            Icons.folder,
            langProvider.getTranslation('projects'),
            () {
              Navigator.pop(context);
              _scrollToSection(size.height * 2.8);
            },
          ),
          _buildDrawerItem(
            context,
            Icons.work,
            langProvider.getTranslation('experience'),
            () {
              Navigator.pop(context);
              _scrollToSection(size.height * 3.5);
            },
          ),
          _buildDrawerItem(
            context,
            Icons.terminal,
            langProvider.getTranslation('terminal'),
            () {
              Navigator.pop(context);
              _scrollToSection(size.height * 4.5);
            },
          ),
          _buildDrawerItem(
            context,
            Icons.email,
            langProvider.getTranslation('contact'),
            () {
              Navigator.pop(context);
              _scrollToSection(size.height * 5.5);
            },
          ),
          const Divider(color: Color(0xFF00ff41), height: 20),
          _buildDrawerItem(
            context,
            Icons.language,
            langProvider.getTranslation('home'),
            () => langProvider.toggleLanguage(),
            suffix: '🌍',
          ),
          Consumer<ThemeProvider>(
            builder: (context, theme, _) {
              return _buildDrawerItem(
                context,
                theme.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                theme.isDarkMode ? 'Light Mode' : 'Dark Mode',
                () => theme.toggleTheme(),
                suffix: theme.isDarkMode ? '☀️' : '🌙',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    String? suffix,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF00ff41)),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'JetBrains Mono',
        ),
      ),
      trailing: suffix != null
          ? Text(suffix, style: const TextStyle(fontSize: 18))
          : null,
      onTap: onTap,
      hoverColor: const Color(0xFF00ff41).withOpacity(0.1),
    );
  }
}