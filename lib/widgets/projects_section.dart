// widgets/projects_section.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../models/project_model.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Column(
        children: [
          Text(
            langProvider.getTranslation('projects_title'),
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
            children: projects.map((project) => _ProjectCard(project: project)).toList(),
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool isHovered = false;

  String _getDescription(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context).currentLocale.languageCode;
    switch (lang) {
      case 'fr':
        return widget.project.descriptionFr;
      case 'ar':
        return widget.project.descriptionAr;
      default:
        return widget.project.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 400,
        height: 280,
        decoration: BoxDecoration(
          color: const Color(0xFF0f1419),
          border: Border.all(
            color: isHovered ? const Color(0xFF00ff41) : Colors.white24,
            width: isHovered ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: isHovered
              ? [
                  BoxShadow(
                    color: const Color(0xFF00ff41).withOpacity(0.2),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF00ff41).withOpacity(0.05),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.folder_open, color: Color(0xFF00ff41)),
                      const SizedBox(width: 12),
                      Text(
                        widget.project.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'JetBrains Mono',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (widget.project.githubUrl != null)
                        IconButton(
                          icon: const Icon(Icons.open_in_new, color: Colors.white70, size: 18),
                          onPressed: () {},
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getDescription(context),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.5,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.project.technologies.map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1a1a1a),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Text(
                            tech,
                            style: const TextStyle(
                              color: Color(0xFF00ff41),
                              fontSize: 11,
                              fontFamily: 'JetBrains Mono',
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}