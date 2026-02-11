// widgets/admin/admin_tabs/settings_tab.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/admin_provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Admin Settings',
                style: TextStyle(
                  color: Color(0xFF00ff41),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Card(
                color: const Color(0xFF1a1a1a),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Change Admin Password',
                        style: TextStyle(
                          color: Color(0xFF00ff41),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ChangePasswordForm(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                color: const Color(0xFF1a1a1a),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Portfolio Information',
                        style: TextStyle(
                          color: Color(0xFF00ff41),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        title: const Text('Total Projects'),
                        trailing: Text(
                          '${adminProvider.projects.length}',
                          style: const TextStyle(
                            color: Color(0xFF00ff41),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text('Total Skills'),
                        trailing: Text(
                          '${adminProvider.skills.length}',
                          style: const TextStyle(
                            color: Color(0xFF00ff41),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text('Total Experiences'),
                        trailing: Text(
                          '${adminProvider.experiences.length}',
                          style: const TextStyle(
                            color: Color(0xFF00ff41),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text('Available Themes'),
                        trailing: Text(
                          '${adminProvider.themes.length}',
                          style: const TextStyle(
                            color: Color(0xFF00ff41),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                color: const Color(0xFF1a1a1a),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About This Admin Panel',
                        style: TextStyle(
                          color: Color(0xFF00ff41),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'This admin panel allows you to manage all aspects of your portfolio:',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        '• Projects: Add, edit, and delete your portfolio projects\n'
                        '• Skills: Manage your technical skills and expertise levels\n'
                        '• Experience: Update your professional experience\n'
                        '• Contact: Manage your contact information and social links\n'
                        '• Themes: Create and customize color themes\n'
                        '• Settings: Manage admin password and view statistics',
                        style: TextStyle(
                          color: Colors.white70,
                          height: 1.8,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  bool _showOldPassword = false;
  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() {
    if (_oldPasswordController.text.isEmpty ||
        _newPasswordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New passwords do not match')),
      );
      return;
    }

    context.read<AdminProvider>().changeAdminPassword(
      _oldPasswordController.text,
      _newPasswordController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password changed successfully!')),
    );

    _oldPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _oldPasswordController,
          obscureText: !_showOldPassword,
          decoration: InputDecoration(
            labelText: 'Old Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _showOldPassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() => _showOldPassword = !_showOldPassword);
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _newPasswordController,
          obscureText: !_showNewPassword,
          decoration: InputDecoration(
            labelText: 'New Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _showNewPassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() => _showNewPassword = !_showNewPassword);
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _confirmPasswordController,
          obscureText: !_showConfirmPassword,
          decoration: InputDecoration(
            labelText: 'Confirm New Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() => _showConfirmPassword = !_showConfirmPassword);
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00ff41),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            onPressed: _changePassword,
            child: const Text(
              'Change Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
