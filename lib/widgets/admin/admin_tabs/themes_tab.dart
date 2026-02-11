// widgets/admin/admin_tabs/themes_tab.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/admin_provider.dart';
import '../../../models/admin_model.dart';

class ThemesTab extends StatefulWidget {
  const ThemesTab({super.key});

  @override
  State<ThemesTab> createState() => _ThemesTabState();
}

class _ThemesTabState extends State<ThemesTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, _) {
        return Scaffold(
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: adminProvider.themes.length,
            itemBuilder: (context, index) {
              final theme = adminProvider.themes[index];
              final isSelected = index == adminProvider.selectedThemeIndex;
              return ThemeCard(
                theme: theme,
                isSelected: isSelected,
                onSelect: () => adminProvider.selectTheme(index),
                onEdit: () => _showThemeDialog(context, index, theme),
                onDelete: adminProvider.themes.length > 1
                    ? () => _showDeleteConfirmation(context, index)
                    : null,
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF00ff41),
            foregroundColor: Colors.black,
            onPressed: () => _showThemeDialog(context, -1, null),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _showThemeDialog(BuildContext context, int index, ThemeCustom? theme) {
    showDialog(
      context: context,
      builder: (context) => ThemeEditDialog(
        theme: theme,
        onSave: (newTheme) {
          if (index == -1) {
            context.read<AdminProvider>().addTheme(newTheme);
          } else {
            context.read<AdminProvider>().updateTheme(index, newTheme);
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
        title: const Text('Delete Theme?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AdminProvider>().deleteTheme(index);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class ThemeCard extends StatelessWidget {
  final ThemeCustom theme;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onEdit;
  final VoidCallback? onDelete;

  const ThemeCard({
    required this.theme,
    required this.isSelected,
    required this.onSelect,
    required this.onEdit,
    this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? const Color(0xFF00ff41) : Colors.transparent,
          width: 2,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    theme.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    theme.brightness == Brightness.dark ? 'Dark Mode' : 'Light Mode',
                    style: const TextStyle(color: Colors.white54),
                  ),
                ],
              ),
              if (isSelected)
                const Chip(
                  label: Text('Active', style: TextStyle(color: Colors.black)),
                  backgroundColor: Color(0xFF00ff41),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _colorPreview(theme.primaryColor),
              const SizedBox(width: 8),
              _colorPreview(theme.secondaryColor),
              const SizedBox(width: 8),
              _colorPreview(theme.backgroundColor),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!isSelected)
                TextButton(
                  onPressed: onSelect,
                  child: const Text('Select'),
                ),
              TextButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit, color: Color(0xFF00ff41)),
                label: const Text('Edit'),
              ),
              if (onDelete != null)
                TextButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text('Delete'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _colorPreview(Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white12),
      ),
    );
  }
}

class ThemeEditDialog extends StatefulWidget {
  final ThemeCustom? theme;
  final Function(ThemeCustom) onSave;

  const ThemeEditDialog({
    this.theme,
    required this.onSave,
    super.key,
  });

  @override
  State<ThemeEditDialog> createState() => _ThemeEditDialogState();
}

class _ThemeEditDialogState extends State<ThemeEditDialog> {
  late TextEditingController _nameController;
  late Color _primaryColor;
  late Color _secondaryColor;
  late Color _backgroundColor;
  late Brightness _brightness;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.theme?.name ?? '');
    _primaryColor = widget.theme?.primaryColor ?? const Color(0xFF00ff41);
    _secondaryColor = widget.theme?.secondaryColor ?? const Color(0xFF008f11);
    _backgroundColor = widget.theme?.backgroundColor ?? const Color(0xFF0a0a0a);
    _brightness = widget.theme?.brightness ?? Brightness.dark;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _pickColor(Color initialColor, Function(Color) onColorPicked) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick Color'),
        content: ColorPickerWidget(
          initialColor: initialColor,
          onColorChanged: (color) {
            onColorPicked(color);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.theme == null ? 'New Theme' : 'Edit Theme'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Theme Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Primary Color'),
              trailing: GestureDetector(
                onTap: () => _pickColor(_primaryColor, (color) {
                  setState(() => _primaryColor = color);
                }),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _primaryColor,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.white12),
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Secondary Color'),
              trailing: GestureDetector(
                onTap: () => _pickColor(_secondaryColor, (color) {
                  setState(() => _secondaryColor = color);
                }),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _secondaryColor,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.white12),
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Background Color'),
              trailing: GestureDetector(
                onTap: () => _pickColor(_backgroundColor, (color) {
                  setState(() => _backgroundColor = color);
                }),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _backgroundColor,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.white12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<Brightness>(
              value: _brightness,
              isExpanded: true,
              items: [
                DropdownMenuItem(
                  value: Brightness.dark,
                  child: const Text('Dark Mode'),
                ),
                DropdownMenuItem(
                  value: Brightness.light,
                  child: const Text('Light Mode'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _brightness = value ?? Brightness.dark;
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
            final newTheme = ThemeCustom(
              id: widget.theme?.id ?? DateTime.now().toString(),
              name: _nameController.text,
              primaryColor: _primaryColor,
              secondaryColor: _secondaryColor,
              backgroundColor: _backgroundColor,
              brightness: _brightness,
            );
            widget.onSave(newTheme);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class ColorPickerWidget extends StatefulWidget {
  final Color initialColor;
  final Function(Color) onColorChanged;

  const ColorPickerWidget({
    required this.initialColor,
    required this.onColorChanged,
    super.key,
  });

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  late TextEditingController _hexController;

  @override
  void initState() {
    super.initState();
    _hexController = TextEditingController(
      text: widget.initialColor.value.toRadixString(16).padLeft(8, '0'),
    );
  }

  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: widget.initialColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _hexController,
          decoration: const InputDecoration(
            labelText: 'Hex Color',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            try {
              final color = Color(int.parse('0xFF$value'));
              widget.onColorChanged(color);
            } catch (e) {
              // Invalid hex
            }
          },
        ),
      ],
    );
  }
}
