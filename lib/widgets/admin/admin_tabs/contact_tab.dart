// widgets/admin/admin_tabs/contact_tab.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/admin_provider.dart';
import '../../../models/admin_model.dart';

class ContactTab extends StatefulWidget {
  const ContactTab({super.key});

  @override
  State<ContactTab> createState() => _ContactTabState();
}

class _ContactTabState extends State<ContactTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, _) {
        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ContactEditCard(
              contact: adminProvider.contact,
              onSave: (newContact) {
                adminProvider.updateContact(newContact);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contact updated successfully!')),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class ContactEditCard extends StatefulWidget {
  final Contact contact;
  final Function(Contact) onSave;

  const ContactEditCard({
    required this.contact,
    required this.onSave,
    super.key,
  });

  @override
  State<ContactEditCard> createState() => _ContactEditCardState();
}

class _ContactEditCardState extends State<ContactEditCard> {
  late TextEditingController _githubController;
  late TextEditingController _linkedinController;
  late TextEditingController _emailController;
  late TextEditingController _twitterController;
  late TextEditingController _tryhackmeController;

  @override
  void initState() {
    super.initState();
    _githubController = TextEditingController(text: widget.contact.github);
    _linkedinController = TextEditingController(text: widget.contact.linkedin);
    _emailController = TextEditingController(text: widget.contact.email);
    _twitterController = TextEditingController(text: widget.contact.twitter);
    _tryhackmeController = TextEditingController(text: widget.contact.tryhackme);
  }

  @override
  void dispose() {
    _githubController.dispose();
    _linkedinController.dispose();
    _emailController.dispose();
    _twitterController.dispose();
    _tryhackmeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1a1a1a),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Information',
              style: TextStyle(
                color: Color(0xFF00ff41),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildContactField(
              controller: _githubController,
              label: 'GitHub URL',
              icon: Icons.code,
            ),
            _buildContactField(
              controller: _linkedinController,
              label: 'LinkedIn URL',
              icon: Icons.business,
            ),
            _buildContactField(
              controller: _emailController,
              label: 'Email Address',
              icon: Icons.email,
            ),
            _buildContactField(
              controller: _twitterController,
              label: 'Twitter URL',
              icon: Icons.public,
            ),
            _buildContactField(
              controller: _tryhackmeController,
              label: 'TryHackMe URL',
              icon: Icons.security,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00ff41),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  final newContact = Contact(
                    github: _githubController.text,
                    linkedin: _linkedinController.text,
                    email: _emailController.text,
                    twitter: _twitterController.text,
                    tryhackme: _tryhackmeController.text,
                  );
                  widget.onSave(newContact);
                },
                child: const Text(
                  'Save Contact Information',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xFF00ff41)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF00ff41)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF00ff41), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF00ff41), width: 2),
          ),
          labelStyle: const TextStyle(color: Color(0xFF00ff41)),
        ),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
