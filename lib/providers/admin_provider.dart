// providers/admin_provider.dart
import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../models/admin_model.dart';

class AdminProvider extends ChangeNotifier {
  late List<Project> _projects;
  late List<Skill> _skills;
  late List<Experience> _experiences;
  late Contact _contact;
  late List<ThemeCustom> _themes;
  late int _selectedThemeIndex;
  
  String _adminPassword = 'admin123'; // À changer en production
  bool _isAdminLoggedIn = false;
  
  // Getters
  List<Project> get projects => _projects;
  List<Skill> get skills => _skills;
  List<Experience> get experiences => _experiences;
  Contact get contact => _contact;
  List<ThemeCustom> get themes => _themes;
  ThemeCustom get currentTheme => _themes[_selectedThemeIndex];
  int get selectedThemeIndex => _selectedThemeIndex;
  bool get isAdminLoggedIn => _isAdminLoggedIn;
  
  AdminProvider() {
    _initializeData();
  }
  
  void _initializeData() {
    // Initialiser les projets avec les données du modèle
    _projects = [];
    
    _skills = [
      Skill(id: '1', name: 'Wazuh', category: 'Monitoring', level: 5),
      Skill(id: '2', name: 'Suricata', category: 'Cybersecurity', level: 4),
      Skill(id: '3', name: 'Java', category: 'Development', level: 5),
      Skill(id: '4', name: 'Python', category: 'Development', level: 5),
      Skill(id: '5', name: 'Network Security', category: 'Cybersecurity', level: 4),
      Skill(id: '6', name: 'TensorFlow', category: 'AI/ML', level: 4),
      Skill(id: '7', name: 'React', category: 'Development', level: 4),
      Skill(id: '8', name: 'Spring Boot', category: 'Development', level: 4),
      Skill(id: '9', name: 'Cisco Networks', category: 'Networking', level: 4),
      Skill(id: '10', name: 'Linux', category: 'Cybersecurity', level: 5),
    ];
    
    _experiences = [
      Experience(
        id: '1',
        title: 'Cybersecurity Engineer Intern',
        company: 'Tech Company',
        description: 'Worked on SOC monitoring and security analysis',
        descriptionFr: 'Travaillé sur la surveillance SOC et l\'analyse de sécurité',
        descriptionAr: 'عمل على مراقبة SOC وتحليل الأمان',
        startDate: DateTime(2024, 6),
        endDate: DateTime(2024, 8),
        isCurrent: false,
      ),
      Experience(
        id: '2',
        title: 'Full Stack Developer',
        company: 'ConnectSoft',
        description: 'Co-founder developing web applications',
        descriptionFr: 'Co-fondateur développant des applications web',
        descriptionAr: 'مؤسس مشارك يطور تطبيقات ويب',
        startDate: DateTime(2024, 1),
        endDate: null,
        isCurrent: true,
      ),
    ];
    
    _contact = Contact(
      github: 'https://github.com/sidatt',
      linkedin: 'https://linkedin.com/in/sidatt',
      email: 'sidatt@example.com',
      twitter: 'https://twitter.com/sidatt',
      tryhackme: 'https://tryhackme.com/p/sidatt',
    );
    
    _themes = [
      ThemeCustom(
        id: '1',
        name: 'Dark Terminal',
        primaryColor: const Color(0xFF00ff41),
        secondaryColor: const Color(0xFF008f11),
        backgroundColor: const Color(0xFF0a0a0a),
        brightness: Brightness.dark,
      ),
      ThemeCustom(
        id: '2',
        name: 'Light Professional',
        primaryColor: const Color(0xFF1a5f2a),
        secondaryColor: const Color(0xFF3a8f5a),
        backgroundColor: const Color(0xFFf5f5f5),
        brightness: Brightness.light,
      ),
      ThemeCustom(
        id: '3',
        name: 'Ocean Blue',
        primaryColor: const Color(0xFF0066cc),
        secondaryColor: const Color(0xFF0099ff),
        backgroundColor: const Color(0xFF0a1428),
        brightness: Brightness.dark,
      ),
      ThemeCustom(
        id: '4',
        name: 'Purple Passion',
        primaryColor: const Color(0xFF7c3aed),
        secondaryColor: const Color(0xFFa78bfa),
        backgroundColor: const Color(0xFF1e1b4b),
        brightness: Brightness.dark,
      ),
    ];
    
    _selectedThemeIndex = 0;
  }
  
  // Admin Authentication
  bool loginAdmin(String password) {
    if (password == _adminPassword) {
      _isAdminLoggedIn = true;
      notifyListeners();
      return true;
    }
    return false;
  }
  
  void logoutAdmin() {
    _isAdminLoggedIn = false;
    notifyListeners();
  }
  
  void changeAdminPassword(String oldPassword, String newPassword) {
    if (oldPassword == _adminPassword) {
      _adminPassword = newPassword;
      notifyListeners();
    }
  }
  
  // Projects Management
  void addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }
  
  void updateProject(int index, Project project) {
    if (index >= 0 && index < _projects.length) {
      _projects[index] = project;
      notifyListeners();
    }
  }
  
  void deleteProject(int index) {
    if (index >= 0 && index < _projects.length) {
      _projects.removeAt(index);
      notifyListeners();
    }
  }
  
  // Skills Management
  void addSkill(Skill skill) {
    _skills.add(skill);
    notifyListeners();
  }
  
  void updateSkill(int index, Skill skill) {
    if (index >= 0 && index < _skills.length) {
      _skills[index] = skill;
      notifyListeners();
    }
  }
  
  void deleteSkill(int index) {
    if (index >= 0 && index < _skills.length) {
      _skills.removeAt(index);
      notifyListeners();
    }
  }
  
  // Experience Management
  void addExperience(Experience experience) {
    _experiences.add(experience);
    notifyListeners();
  }
  
  void updateExperience(int index, Experience experience) {
    if (index >= 0 && index < _experiences.length) {
      _experiences[index] = experience;
      notifyListeners();
    }
  }
  
  void deleteExperience(int index) {
    if (index >= 0 && index < _experiences.length) {
      _experiences.removeAt(index);
      notifyListeners();
    }
  }
  
  // Contact Management
  void updateContact(Contact newContact) {
    _contact = newContact;
    notifyListeners();
  }
  
  // Theme Management
  void selectTheme(int index) {
    if (index >= 0 && index < _themes.length) {
      _selectedThemeIndex = index;
      notifyListeners();
    }
  }
  
  void addTheme(ThemeCustom theme) {
    _themes.add(theme);
    notifyListeners();
  }
  
  void updateTheme(int index, ThemeCustom theme) {
    if (index >= 0 && index < _themes.length) {
      _themes[index] = theme;
      notifyListeners();
    }
  }
  
  void deleteTheme(int index) {
    if (index >= 0 && index < _themes.length && _themes.length > 1) {
      _themes.removeAt(index);
      if (_selectedThemeIndex >= _themes.length) {
        _selectedThemeIndex = _themes.length - 1;
      }
      notifyListeners();
    }
  }
}
