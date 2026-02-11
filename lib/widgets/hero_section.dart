// widgets/hero_section.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../providers/language_provider.dart';

class HeroSection extends StatelessWidget {
  final AnimationController animationController;
  final VoidCallback onScrollToTerminal;

  const HeroSection({
    super.key,
    required this.animationController,
    required this.onScrollToTerminal,
  });

  Future<void> _downloadCV() async {
    try {
      // ✅ Web: ouvre le fichier servi par le site
      // ⚠️ Assure-toi que le PDF existe bien dans: web/assets/cv/CV.pdf
      // Desktop/Mobile: ouvre un lien https public (GitHub raw)
      final Uri uri = kIsWeb
          ? Uri.parse('assets/cv/CV.pdf')
          : Uri.parse(
              'https://raw.githubusercontent.com/sidattBelkhair/sidatt/main/assets/cv/CV.pdf',
            );

      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok) {
        debugPrint('Impossible d’ouvrir le CV: $uri');
      }
    } catch (e) {
      debugPrint('Erreur lors du téléchargement du CV: $e');
    }
  }

  Future<void> _openGithub() async {
    final uri = Uri.parse('https://github.com/sidattBelkhair');
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeTransition(
                  opacity: Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(0, 0.5, curve: Curves.easeOut),
                    ),
                  ),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00ff41).withOpacity(0.1),
                      border: Border.all(color: const Color(0xFF00ff41)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'SECURITY RESEARCHER & DEVELOPER',
                      style: TextStyle(
                        color: Color(0xFF00ff41),
                        fontFamily: 'JetBrains Mono',
                        fontSize: 12,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeTransition(
                  opacity: Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
                    ),
                  ),
                  child: Text(
                    'SIDATT TALEB\nBELKHAIR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width > 800 ? 64 : 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'JetBrains Mono',
                      height: 1.1,
                      shadows: [
                        Shadow(
                          color: const Color(0xFF00ff41).withOpacity(0.5),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                FadeTransition(
                  opacity: Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
                    ),
                  ),
                  child: Text(
                    langProvider.getTranslation('cybersecurity_engineer'),
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: size.width > 800 ? 24 : 18,
                      fontFamily: 'JetBrains Mono',
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                FadeTransition(
                  opacity: Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Text(
                      langProvider.getTranslation('profile_desc'),
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                FadeTransition(
                  opacity: Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: const Interval(0.8, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _ActionButton(
                        icon: Icons.terminal,
                        label: 'Open Terminal',
                        onPressed: onScrollToTerminal,
                        isPrimary: true,
                      ),
                      _ActionButton(
                        icon: Icons.code,
                        label: langProvider.getTranslation('view_github'),
                        onPressed: _openGithub,
                      ),
                      _ActionButton(
                        icon: Icons.download,
                        label: langProvider.getTranslation('download_cv'),
                        onPressed: _downloadCV,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (size.width > 1000)
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: const Color(0xFF00ff41), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00ff41).withOpacity(0.3),
                        blurRadius: 50,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Container(
                      color: const Color(0xFF1a1a1a),
                      child: const Icon(
                        Icons.security,
                        size: 120,
                        color: Color(0xFF00ff41),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? (isHovered
                    ? const Color(0xFF00ff41)
                    : const Color(0xFF00ff41).withOpacity(0.1))
                : (isHovered
                    ? const Color(0xFF00ff41).withOpacity(0.2)
                    : Colors.transparent),
            border: Border.all(
              color: const Color(0xFF00ff41),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: const Color(0xFF00ff41).withOpacity(0.3),
                      blurRadius: 20,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: widget.isPrimary
                    ? (isHovered ? Colors.black : const Color(0xFF00ff41))
                    : const Color(0xFF00ff41),
                size: 18,
              ),
              const SizedBox(width: 8),

              // ✅ Fix RenderFlex overflow: le texte ne déborde plus
              Flexible(
                child: Text(
                  widget.label,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                    color: widget.isPrimary
                        ? (isHovered ? Colors.black : const Color(0xFF00ff41))
                        : const Color(0xFF00ff41),
                    fontFamily: 'JetBrains Mono',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
