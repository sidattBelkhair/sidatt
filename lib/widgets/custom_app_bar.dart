// widgets/custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../providers/theme_provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(double) onNavigate;
  final ScrollController scrollController;

  const CustomAppBar({
    super.key,
    required this.onNavigate,
    required this.scrollController,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        final isScrolled = scrollController.hasClients && scrollController.offset > 50;
        
        return Container(
          decoration: BoxDecoration(
            color: isScrolled 
                ? const Color(0xFF0a0a0a).withOpacity(0.95)
                : Colors.transparent,
            border: isScrolled
                ? const Border(
                    bottom: BorderSide(color: Color(0xFF00ff41), width: 1),
                  )
                : null,
            boxShadow: isScrolled
                ? [
                    BoxShadow(
                      color: const Color(0xFF00ff41).withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  GestureDetector(
                    onTap: () => onNavigate(0),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF00ff41)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.terminal,
                            color: Color(0xFF00ff41),
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'sidatt@portfolio:~',
                            style: TextStyle(
                              color: Color(0xFF00ff41),
                              fontFamily: 'JetBrains Mono',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  if (!isMobile) ...[
                    // Navigation Links
                    Row(
                      children: [
                        _NavLink(
                          title: langProvider.getTranslation('about'),
                          onTap: () => onNavigate(size.height * 0.8),
                        ),
                        _NavLink(
                          title: langProvider.getTranslation('skills'),
                          onTap: () => onNavigate(size.height * 1.8),
                        ),
                        _NavLink(
                          title: langProvider.getTranslation('projects'),
                          onTap: () => onNavigate(size.height * 2.8),
                        ),
                        _NavLink(
                          title: langProvider.getTranslation('terminal'),
                          onTap: () => onNavigate(size.height * 4.5),
                        ),
                        _NavLink(
                          title: langProvider.getTranslation('contact'),
                          onTap: () => onNavigate(size.height * 5.5),
                        ),
                      ],
                    ),

                    // Controls
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.language, color: Color(0xFF00ff41)),
                          onPressed: () => langProvider.toggleLanguage(),
                          tooltip: 'Change Language',
                        ),
                        Consumer<ThemeProvider>(
                          builder: (context, theme, _) {
                            return IconButton(
                              icon: Icon(
                                theme.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                                color: const Color(0xFF00ff41),
                              ),
                              onPressed: () => theme.toggleTheme(),
                              tooltip: 'Toggle Theme',
                            );
                          },
                        ),
                      ],
                    ),
                  ] else
                    IconButton(
                      icon: const Icon(Icons.menu, color: Color(0xFF00ff41)),
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavLink extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const _NavLink({required this.title, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            border: isHovered
                ? const Border(
                    bottom: BorderSide(color: Color(0xFF00ff41), width: 2),
                  )
                : null,
          ),
          child: Text(
            widget.title,
            style: TextStyle(
              color: isHovered ? const Color(0xFF00ff41) : Colors.white,
              fontFamily: 'JetBrains Mono',
              fontSize: 14,
              fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}