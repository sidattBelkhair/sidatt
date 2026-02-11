// widgets/admin/admin_tabs/experience_tab.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/admin_provider.dart';
import '../../../models/admin_model.dart';

class ExperienceTab extends StatefulWidget {
  const ExperienceTab({super.key});

  @override
  State<ExperienceTab> createState() => _ExperienceTabState();
}

class _ExperienceTabState extends State<ExperienceTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, _) {
        return Scaffold(
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: adminProvider.experiences.length,
            itemBuilder: (context, index) {
              final exp = adminProvider.experiences[index];
              return ExperienceCard(
                experience: exp,
                onEdit: () => _showExpDialog(context, index, exp),
                onDelete: () => _showDeleteConfirmation(context, index),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF00ff41),
            foregroundColor: Colors.black,
            onPressed: () => _showExpDialog(context, -1, null),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _showExpDialog(BuildContext context, int index, Experience? exp) {
    showDialog(
      context: context,
      builder: (context) => ExperienceEditDialog(
        experience: exp,
        onSave: (newExp) {
          if (index == -1) {
            context.read<AdminProvider>().addExperience(newExp);
          } else {
            context.read<AdminProvider>().updateExperience(index, newExp);
          }
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Experience?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AdminProvider>().deleteExperience(index);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class ExperienceCard extends StatelessWidget {
  final Experience experience;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ExperienceCard({
    required this.experience,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1a1a1a),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(experience.title, style: const TextStyle(color: Colors.white)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(experience.company, style: const TextStyle(color: Colors.white70)),
            Text(
              '${experience.startDate.year}-${experience.endDate?.year ?? "Now"}',
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xFF00ff41)),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class ExperienceEditDialog extends StatefulWidget {
  final Experience? experience;
  final Function(Experience) onSave;

  const ExperienceEditDialog({
    this.experience,
    required this.onSave,
    super.key,
  });

  @override
  State<ExperienceEditDialog> createState() => _ExperienceEditDialogState();
}

class _ExperienceEditDialogState extends State<ExperienceEditDialog> {
  late TextEditingController _titleController;
  late TextEditingController _companyController;
  late TextEditingController _descController;
  late TextEditingController _descFrController;
  late TextEditingController _descArController;
  late DateTime _startDate;
  late DateTime? _endDate;
  late bool _isCurrent;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.experience?.title ?? '');
    _companyController = TextEditingController(text: widget.experience?.company ?? '');
    _descController =
        TextEditingController(text: widget.experience?.description ?? '');
    _descFrController =
        TextEditingController(text: widget.experience?.descriptionFr ?? '');
    _descArController =
        TextEditingController(text: widget.experience?.descriptionAr ?? '');
    _startDate = widget.experience?.startDate ?? DateTime.now();
    _endDate = widget.experience?.endDate;
    _isCurrent = widget.experience?.isCurrent ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _companyController.dispose();
    _descController.dispose();
    _descFrController.dispose();
    _descArController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.experience == null ? 'New Experience' : 'Edit Experience'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(_titleController, 'Job Title'),
            _buildTextField(_companyController, 'Company'),
            _buildTextField(_descController, 'Description (EN)'),
            _buildTextField(_descFrController, 'Description (FR)'),
            _buildTextField(_descArController, 'Description (AR)'),
            const SizedBox(height: 12),
            CheckboxListTile(
              title: const Text('Currently Working Here'),
              value: _isCurrent,
              onChanged: (value) {
                setState(() {
                  _isCurrent = value ?? false;
                  if (_isCurrent) {
                    _endDate = null;
                  }
                });
              },
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
            final newExp = Experience(
              id: widget.experience?.id ?? DateTime.now().toString(),
              title: _titleController.text,
              company: _companyController.text,
              description: _descController.text,
              descriptionFr: _descFrController.text,
              descriptionAr: _descArController.text,
              startDate: _startDate,
              endDate: _isCurrent ? null : _endDate,
              isCurrent: _isCurrent,
            );
            widget.onSave(newExp);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        maxLines: label.contains('Description') ? 3 : 1,
      ),
    );
  }
}
