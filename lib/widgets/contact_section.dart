// widgets/contact_section.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Column(
        children: [
          Text(
            langProvider.getTranslation('contact'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              fontFamily: 'JetBrains Mono',
            ),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              _ContactCard(
                icon: Icons.email,
                title: 'Email',
                value: 'belkhairtaleb@gmail.com',
                onTap: () => launchUrl(Uri.parse('mailto:belkhairtaleb@gmail.com')),
              ),
              _ContactCard(
                icon: Icons.phone,
                title: 'Phone',
                value: '+222 32 46 05 18',
                onTap: () => launchUrl(Uri.parse('tel:+22232460518')),
              ),
              _ContactCard(
                icon: Icons.code,
                title: 'GitHub',
                value: 'sidattBelkhair',
                onTap: () => launchUrl(Uri.parse('https://github.com/sidattBelkhair')),
              ),
              _ContactCard(
                icon: Icons.security,
                title: 'TryHackMe',
                value: 'SidattBelkhair',
                onTap: () => launchUrl(Uri.parse('https://tryhackme.com/p/SidattBelkhair')),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF00ff41).withOpacity(0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              children: [
                Icon(Icons.location_on, color: Color(0xFF00ff41), size: 32),
                SizedBox(height: 12),
                Text(
                  'Nouakchott, Mauritanie',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'JetBrains Mono',
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

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 280,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isHovered ? const Color(0xFF1a1a1a) : const Color(0xFF0f1419),
            border: Border.all(
              color: isHovered ? const Color(0xFF00ff41) : Colors.white24,
              width: isHovered ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF00ff41).withOpacity(0.2),
                      blurRadius: 20,
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              Icon(
                widget.icon,
                color: const Color(0xFF00ff41),
                size: 32,
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontFamily: 'JetBrains Mono',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'JetBrains Mono',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}