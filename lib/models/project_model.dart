// models/project_model.dart
class Project {
  final String name;
  final String description;
  final String descriptionFr;
  final String descriptionAr;
  final List<String> technologies;
  final String? githubUrl;
  final String? demoUrl;
  final String category;
  final DateTime? date;

  Project({
    required this.name,
    required this.description,
    required this.descriptionFr,
    required this.descriptionAr,
    required this.technologies,
    this.githubUrl,
    this.demoUrl,
    required this.category,
    this.date,
  });
}

final List<Project> projects = [
  Project(
    name: 'Devoir_Soa_project',
    description: 'Bank card management system with secure transaction handling',
    descriptionFr: 'Système de gestion des cartes bancaires avec traitement sécurisé des transactions',
    descriptionAr: 'نظام إدارة بطاقات بنكية مع معالجة آمنة للمعاملات',
    technologies: ['Java', 'Spring Boot', 'REST API', 'PostgreSQL'],
    category: 'Backend',
    date: DateTime(2025, 1),
  ),
  Project(
    name: 'Sentim_AI',
    description: 'AI-powered sentiment analysis application using Python',
    descriptionFr: 'Application d\'analyse de sentiment basée sur l\'IA utilisant Python',
    descriptionAr: 'تطبيق تحليل المشاعر بالذكاء الاصطناعي باستخدام بايثون',
    technologies: ['Python', 'TensorFlow', 'NLP', 'Flask'],
    category: 'AI/ML',
    date: DateTime(2025, 1),
  ),
  Project(
    name: 'SOC Lab',
    description: 'Security Operations Center lab with Wazuh, Suricata, pfSense, TheHive and Cortex',
    descriptionFr: 'Laboratoire SOC avec Wazuh, Suricata, pfSense, TheHive et Cortex',
    descriptionAr: 'مختبر مركز عمليات الأمن مع Wazuh وSuricata وpfSense وTheHive وCortex',
    technologies: ['Wazuh', 'Suricata', 'pfSense', 'TheHive', 'Cortex', 'Linux'],
    category: 'Cybersecurity',
    date: DateTime(2024, 12),
  ),
  Project(
    name: 'Student Orientation App',
    description: 'Web application for student orientation using HTML/CSS/JS/PHP-MySQL',
    descriptionFr: 'Application web d\'orientation étudiante utilisant HTML/CSS/JS/PHP-MySQL',
    descriptionAr: 'تطبيق ويب لتوجيه الطلاب باستخدام HTML/CSS/JS/PHP-MySQL',
    technologies: ['HTML', 'CSS', 'JavaScript', 'PHP', 'MySQL'],
    category: 'Web Development',
    date: DateTime(2024, 11),
  ),
  Project(
    name: 'Thesis Management System',
    description: 'Thesis management system built with React, Spring Boot, and PostgreSQL',
    descriptionFr: 'Système de gestion des thèses construit avec React, Spring Boot et PostgreSQL',
    descriptionAr: 'نظام إدارة الأطروحات مبني بـ React وSpring Boot وPostgreSQL',
    technologies: ['React', 'Spring Boot', 'PostgreSQL', 'REST API'],
    category: 'Full Stack',
    date: DateTime(2024, 10),
  ),
  Project(
    name: 'VLAN Networks',
    description: 'Network configuration and VLAN implementation with SSH, VTP, Telnet',
    descriptionFr: 'Configuration réseau et implémentation VLAN avec SSH, VTP, Telnet',
    descriptionAr: 'تكوين الشبكة وتنفيذ VLAN مع SSH وVTP وTelnet',
    technologies: ['Cisco', 'VLAN', 'SSH', 'VTP', 'Telnet', 'Packet Tracer'],
    category: 'Networking',
    date: DateTime(2024, 9),
  ),
  Project(
    name: 'NuitRamadan',
    description: 'Ramadan night activities management application',
    descriptionFr: 'Application de gestion des activités de la nuit du Ramadan',
    descriptionAr: 'تطبيق إدارة أنشطة ليالي رمضان',
    technologies: ['CSS', 'HTML', 'JavaScript'],
    category: 'Web Development',
    date: DateTime(2025, 3),
  ),
  Project(
    name: 'defi2',
    description: 'Challenge project with modern CSS styling',
    descriptionFr: 'Projet défi avec style CSS moderne',
    descriptionAr: 'مشروع تحدي مع تصميم CSS حديث',
    technologies: ['CSS', 'HTML'],
    category: 'Frontend',
    date: DateTime(2025, 3),
  ),
];