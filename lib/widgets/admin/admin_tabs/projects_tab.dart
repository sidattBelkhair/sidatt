// widgets/admin/admin_tabs/projects_tab.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/admin_provider.dart';
import '../../../models/project_model.dart';

class ProjectsTab extends StatefulWidget {
  const ProjectsTab({super.key});

  @override
  State<ProjectsTab> createState() => _ProjectsTabState();
}

class _ProjectsTabState extends State<ProjectsTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, _) {
        return Scaffold(
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: adminProvider.projects.length,
            itemBuilder: (context, index) {
              final project = adminProvider.projects[index];
              return ProjectCard(
                project: project,
                onEdit: () => _showProjectDialog(context, index, project),
                onDelete: () => _showDeleteConfirmation(context, index),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF00ff41),
            foregroundColor: Colors.black,
            onPressed: () => _showProjectDialog(context, -1, null),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _showProjectDialog(BuildContext context, int index, Project? project) {
    showDialog(
      context: context,
      builder: (context) => ProjectEditDialog(
        project: project,
        onSave: (newProject) {
          if (index == -1) {
            context.read<AdminProvider>().addProject(newProject);
          } else {
            context.read<AdminProvider>().updateProject(index, newProject);
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
        title: const Text('Delete Project?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AdminProvider>().deleteProject(index);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProjectCard({
    required this.project,
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
        title: Text(project.name, style: const TextStyle(color: Colors.white)),
        subtitle: Text(
          project.category,
          style: const TextStyle(color: Colors.white54),
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

class ProjectEditDialog extends StatefulWidget {
  final Project? project;
  final Function(Project) onSave;

  const ProjectEditDialog({
    this.project,
    required this.onSave,
    super.key,
  });

  @override
  State<ProjectEditDialog> createState() => _ProjectEditDialogState();
}

class _ProjectEditDialogState extends State<ProjectEditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _descFrController;
  late TextEditingController _descArController;
  late TextEditingController _techController;
  late TextEditingController _githubController;
  late TextEditingController _demoController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project?.name ?? '');
    _descController =
        TextEditingController(text: widget.project?.description ?? '');
    _descFrController =
        TextEditingController(text: widget.project?.descriptionFr ?? '');
    _descArController =
        TextEditingController(text: widget.project?.descriptionAr ?? '');
    _techController = TextEditingController(
        text: widget.project?.technologies.join(', ') ?? '');
    _githubController =
        TextEditingController(text: widget.project?.githubUrl ?? '');
    _demoController =
        TextEditingController(text: widget.project?.demoUrl ?? '');
    _categoryController =
        TextEditingController(text: widget.project?.category ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    _descFrController.dispose();
    _descArController.dispose();
    _techController.dispose();
    _githubController.dispose();
    _demoController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.project == null ? 'New Project' : 'Edit Project'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(_nameController, 'Project Name'),
            _buildTextField(_descController, 'Description (EN)'),
            _buildTextField(_descFrController, 'Description (FR)'),
            _buildTextField(_descArController, 'Description (AR)'),
            _buildTextField(_techController, 'Technologies (comma separated)'),
            _buildTextField(_githubController, 'GitHub URL'),
            _buildTextField(_demoController, 'Demo URL'),
            _buildTextField(_categoryController, 'Category'),
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
            final newProject = Project(
              name: _nameController.text,
              description: _descController.text,
              descriptionFr: _descFrController.text,
              descriptionAr: _descArController.text,
              technologies:
                  _techController.text.split(',').map((e) => e.trim()).toList(),
              githubUrl: _githubController.text.isEmpty ? null : _githubController.text,
              demoUrl: _demoController.text.isEmpty ? null : _demoController.text,
              category: _categoryController.text,
              date: widget.project?.date ?? DateTime.now(),
            );
            widget.onSave(newProject);
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
