// widgets/footer.dart
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Color(0xFF333333)),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.terminal, color: Color(0xFF00ff41), size: 16),
              const SizedBox(width: 8),
              Text(
                'Designed & Built by Sidatt Belkhair',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontFamily: 'JetBrains Mono',
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '© 2025 All rights reserved.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _FooterLink(label: 'GitHub', onTap: () {}),
              const Text(' • ', style: TextStyle(color: Colors.white24)),
              _FooterLink(label: 'LinkedIn', onTap: () {}),
              const Text(' • ', style: TextStyle(color: Colors.white24)),
              _FooterLink(label: 'TryHackMe', onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF00ff41),
            fontSize: 12,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}