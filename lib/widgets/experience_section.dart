// widgets/experience_section.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    
    final experiences = [
      {
        'title': 'Stagiaire – ADIAS (Nouakchott)',
        'date': '2024',
        'points': ['Monitoring (machines/serveurs/routeurs)', 'Grafana, Loki, Promtail'],
      },
      {
        'title': 'Stagiaire – SNIM (Nouadhibou)',
        'date': '2024',
        'points': ['Projets réseaux & cybersécurité', 'Procédures de sécurité IT'],
      },
    ];

    final entrepreneur = {
      'title': 'Co-fondateur – ConnectSoft',
      'description': 'Startup de gestion des files d\'attente',
    };

    final events = [
      'GAICA 2025 (VIP) – Sousse, Tunisie',
      'Financial Afrik 2025 – Idée innovante (GreenHouse)',
      'Première conférence IA – Nouakchott (participant)',
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Column(
        children: [
          Text(
            langProvider.getTranslation('experience_title'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              fontFamily: 'JetBrains Mono',
            ),
          ),
          const SizedBox(height: 60),
          Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              ...experiences.map((exp) => _ExperienceCard(
                title: exp['title'] as String,
                date: exp['date'] as String,
                points: exp['points'] as List<String>,
              )),
            ],
          ),
          const SizedBox(height: 60),
          _EntrepreneurshipCard(data: entrepreneur),
          const SizedBox(height: 60),
          _EventsSection(events: events, langProvider: langProvider),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final String title;
  final String date;
  final List<String> points;

  const _ExperienceCard({
    required this.title,
    required this.date,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0f1419),
        border: Border.all(color: const Color(0xFF00ff41).withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'JetBrains Mono',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF00ff41).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  date,
                  style: const TextStyle(
                    color: Color(0xFF00ff41),
                    fontSize: 12,
                    fontFamily: 'JetBrains Mono',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...points.map((point) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.arrow_right, color: Color(0xFF00ff41), size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    point,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _EntrepreneurshipCard extends StatelessWidget {
  final Map<String, String> data;

  const _EntrepreneurshipCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 840),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF00ff41).withOpacity(0.1),
            const Color(0xFF008f11).withOpacity(0.05),
          ],
        ),
        border: Border.all(color: const Color(0xFF00ff41)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          const Icon(Icons.rocket_launch, color: Color(0xFF00ff41), size: 40),
          const SizedBox(height: 16),
          Text(
            data['title']!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'JetBrains Mono',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data['description']!,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _EventsSection extends StatelessWidget {
  final List<String> events;
  final dynamic langProvider;

  const _EventsSection({required this.events, required this.langProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          langProvider.getTranslation('events'),
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
          children: events.map((event) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF1a1a1a),
                border: Border.all(color: Colors.white24),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.event, color: Color(0xFF00ff41)),
                  const SizedBox(width: 12),
                  Text(
                    event,
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