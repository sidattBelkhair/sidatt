// widgets/skills_section.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    
    final skills = {
      'cybersecurity': ['Penetration Testing', 'CTF (TryHackMe)', 'DevSecOps', 'Wazuh', 'Suricata', 'pfSense', 'TheHive', 'Cortex'],
      'networking': ['VLANs', 'Routing', 'SSH', 'Packet Tracer', 'Virtualization', 'VTP', 'Telnet'],
      'monitoring': ['Grafana', 'Loki', 'Promtail', 'SOC Operations'],
      'development': ['Java', 'Python', 'JavaScript', 'React', 'Spring Boot', 'Django', 'TypeScript', 'HTML/CSS'],
      'ai_ml': ['Scikit-learn', 'TensorFlow', 'PyTorch', 'Keras', 'NLP'],
      'other': ['Docker', 'Flutter', 'Supabase', 'PostgreSQL', 'Git', 'Linux'],
    };

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Column(
        children: [
          Text(
            langProvider.getTranslation('skills_categories'),
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
            children: skills.entries.map((entry) {
              return _SkillCard(
                title: langProvider.getTranslation(entry.key),
                skills: entry.value,
                icon: _getIconForCategory(entry.key),
              );
            }).toList(),
          ),
          const SizedBox(height: 60),
          _CertificationsSection(langProvider: langProvider),
        ],
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'cybersecurity':
        return Icons.security;
      case 'networking':
        return Icons.network_check;
      case 'monitoring':
        return Icons.monitor_heart;
      case 'development':
        return Icons.code;
      case 'ai_ml':
        return Icons.psychology;
      default:
        return Icons.build;
    }
  }
}

class _SkillCard extends StatefulWidget {
  final String title;
  final List<String> skills;
  final IconData icon;

  const _SkillCard({
    required this.title,
    required this.skills,
    required this.icon,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 350,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isHovered ? const Color(0xFF1a1a1a) : const Color(0xFF0f1419),
          border: Border.all(
            color: isHovered ? const Color(0xFF00ff41) : Colors.white24,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: const Color(0xFF00ff41).withOpacity(0.1),
                    blurRadius: 20,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(widget.icon, color: const Color(0xFF00ff41)),
                const SizedBox(width: 12),
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'JetBrains Mono',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.white24),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.skills.map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00ff41).withOpacity(0.1),
                    border: Border.all(color: const Color(0xFF00ff41).withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    skill,
                    style: const TextStyle(
                      color: Color(0xFF00ff41),
                      fontSize: 12,
                      fontFamily: 'JetBrains Mono',
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _CertificationsSection extends StatelessWidget {
  final dynamic langProvider;

  const _CertificationsSection({required this.langProvider});

  @override
  Widget build(BuildContext context) {
    final certifications = [
      'AWS Academy - Cloud Foundations',
      'Leadership & Management - Alison',
      'JavaScript - Alison',
      'Hashgraph Developer Course',
    ];

    return Column(
      children: [
        Text(
          langProvider.getTranslation('certifications'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'JetBrains Mono',
          ),
        ),
        const SizedBox(height: 30),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: certifications.map((cert) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF00ff41).withOpacity(0.1),
                    const Color(0xFF008f11).withOpacity(0.1),
                  ],
                ),
                border: Border.all(color: const Color(0xFF00ff41)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.verified, color: Color(0xFF00ff41), size: 20),
                  const SizedBox(width: 8),
                  Text(
                    cert,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'JetBrains Mono',
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}