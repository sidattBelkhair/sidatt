// widgets/admin/admin_tabs/skills_tab.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/admin_provider.dart';
import '../../../models/admin_model.dart';

class SkillsTab extends StatefulWidget {
  const SkillsTab({super.key});

  @override
  State<SkillsTab> createState() => _SkillsTabState();
}

class _SkillsTabState extends State<SkillsTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, _) {
        final skillsByCategory = <String, List<Skill>>{};
        for (var skill in adminProvider.skills) {
          skillsByCategory.putIfAbsent(skill.category, () => []).add(skill);
        }

        return Scaffold(
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: skillsByCategory.entries.map((entry) {
              return SkillCategorySection(
                category: entry.key,
                skills: entry.value,
                onAddSkill: () =>
                    _showSkillDialog(context, -1, null, entry.key),
              );
            }).toList(),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF00ff41),
            foregroundColor: Colors.black,
            onPressed: () => _showSkillDialog(context, -1, null, 'Development'),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _showSkillDialog(BuildContext context, int index, Skill? skill,
      String defaultCategory) {
    showDialog(
      context: context,
      builder: (context) => SkillEditDialog(
        skill: skill ?? Skill(id: '', name: '', category: defaultCategory, level: 3),
        onSave: (newSkill) {
          if (index == -1) {
            context.read<AdminProvider>().addSkill(newSkill);
          } else {
            context.read<AdminProvider>().updateSkill(index, newSkill);
          }
          Navigator.pop(context);
        },
      ),
    );
  }
}

class SkillCategorySection extends StatelessWidget {
  final String category;
  final List<Skill> skills;
  final VoidCallback onAddSkill;

  const SkillCategorySection({
    required this.category,
    required this.skills,
    required this.onAddSkill,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1a1a1a),
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    color: Color(0xFF00ff41),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Color(0xFF00ff41)),
                  onPressed: onAddSkill,
                ),
              ],
            ),
          ),
          ...skills.map((skill) => SkillTile(skill: skill)).toList(),
        ],
      ),
    );
  }
}

class SkillTile extends StatelessWidget {
  final Skill skill;

  const SkillTile({required this.skill, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(skill.name, style: const TextStyle(color: Colors.white)),
              Row(
                children: [
                  ...List.generate(
                    5,
                    (i) => Icon(
                      i < skill.level ? Icons.star : Icons.star_outline,
                      color: const Color(0xFF00ff41),
                      size: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFF00ff41)),
                iconSize: 20,
                onPressed: () {
                  // TODO: Implement edit
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                iconSize: 20,
                onPressed: () {
                  // TODO: Implement delete
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SkillEditDialog extends StatefulWidget {
  final Skill skill;
  final Function(Skill) onSave;

  const SkillEditDialog({
    required this.skill,
    required this.onSave,
    super.key,
  });

  @override
  State<SkillEditDialog> createState() => _SkillEditDialogState();
}

class _SkillEditDialogState extends State<SkillEditDialog> {
  late TextEditingController _nameController;
  late String _selectedCategory;
  late int _selectedLevel;

  final List<String> _categories = [
    'Cybersecurity',
    'Networking',
    'Development',
    'AI/ML',
    'Monitoring',
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.skill.name);
    _selectedCategory = widget.skill.category;
    _selectedLevel = widget.skill.level;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Skill'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Skill Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedCategory,
              isExpanded: true,
              items: _categories
                  .map((cat) => DropdownMenuItem(
                        value: cat,
                        child: Text(cat),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Level:'),
                Slider(
                  value: _selectedLevel.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _selectedLevel = value.toInt();
                    });
                  },
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: '$_selectedLevel / 5',
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final newSkill = Skill(
              id: widget.skill.id,
              name: _nameController.text,
              category: _selectedCategory,
              level: _selectedLevel,
            );
            widget.onSave(newSkill);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
