// models/admin_model.dart
import 'package:flutter/material.dart';

class Skill {
  final String id;
  final String name;
  final String category; // Cybersecurity, Networking, Development, AI/ML, Monitoring
  final int level; // 1-5
  
  Skill({
    required this.id,
    required this.name,
    required this.category,
    required this.level,
  });
  
  Skill copyWith({String? name, String? category, int? level}) {
    return Skill(
      id: id,
      name: name ?? this.name,
      category: category ?? this.category,
      level: level ?? this.level,
    );
  }
}

class Experience {
  final String id;
  final String title;
  final String company;
  final String description;
  final String descriptionFr;
  final String descriptionAr;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isCurrent;
  
  Experience({
    required this.id,
    required this.title,
    required this.company,
    required this.description,
    required this.descriptionFr,
    required this.descriptionAr,
    required this.startDate,
    this.endDate,
    this.isCurrent = false,
  });
  
  Experience copyWith({
    String? title,
    String? company,
    String? description,
    String? descriptionFr,
    String? descriptionAr,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrent,
  }) {
    return Experience(
      id: id,
      title: title ?? this.title,
      company: company ?? this.company,
      description: description ?? this.description,
      descriptionFr: descriptionFr ?? this.descriptionFr,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrent: isCurrent ?? this.isCurrent,
    );
  }
}

class Contact {
  final String github;
  final String linkedin;
  final String email;
  final String twitter;
  final String tryhackme;
  
  Contact({
    required this.github,
    required this.linkedin,
    required this.email,
    required this.twitter,
    required this.tryhackme,
  });
  
  Contact copyWith({
    String? github,
    String? linkedin,
    String? email,
    String? twitter,
    String? tryhackme,
  }) {
    return Contact(
      github: github ?? this.github,
      linkedin: linkedin ?? this.linkedin,
      email: email ?? this.email,
      twitter: twitter ?? this.twitter,
      tryhackme: tryhackme ?? this.tryhackme,
    );
  }
}

class ThemeCustom {
  final String id;
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Brightness brightness;
  
  ThemeCustom({
    required this.id,
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.brightness,
  });
  
  ThemeData toThemeData() {
    return ThemeData(
      brightness: brightness,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primaryColor,
        onPrimary: brightness == Brightness.dark ? Colors.black : Colors.white,
        secondary: secondaryColor,
        onSecondary: brightness == Brightness.dark ? Colors.black : Colors.white,
        error: Colors.red,
        onError: Colors.white,
        surface: brightness == Brightness.dark ? const Color(0xFF1a1a1a) : const Color(0xFFf5f5f5),
        onSurface: brightness == Brightness.dark ? Colors.white : Colors.black,
        background: backgroundColor,
        onBackground: brightness == Brightness.dark ? Colors.white : Colors.black,
      ),
    );
  }
}
