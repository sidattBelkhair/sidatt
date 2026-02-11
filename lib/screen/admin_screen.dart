// screens/admin_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/admin_provider.dart';
import '../widgets/admin/admin_login.dart';
import '../widgets/admin/admin_dashboard.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, _) {
        if (!adminProvider.isAdminLoggedIn) {
          return const AdminLoginPage();
        }
        return const AdminDashboard();
      },
    );
  }
}
