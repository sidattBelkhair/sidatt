// widgets/terminal_section.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../models/project_model.dart';

class TerminalSection extends StatefulWidget {
  const TerminalSection({super.key});

  @override
  State<TerminalSection> createState() => _TerminalSectionState();
}

class _TerminalSectionState extends State<TerminalSection> with TickerProviderStateMixin {
  final List<String> _history = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  
  late AnimationController _cursorController;
  bool _showCursor = true;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {
          _showCursor = _cursorController.value < 0.5;
        });
      });
    _cursorController.repeat();
    
    // Initial welcome message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addToHistory(Provider.of<LanguageProvider>(context, listen: false).getTranslation('terminal_welcome'));
    });
  }

  @override
  void dispose() {
    _cursorController.dispose();
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _addToHistory(String text) {
    setState(() {
      _history.add(text);
    });
    Future.delayed(const Duration(milliseconds: 50), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _executeCommand(String command) {
    final langProvider = Provider.of<LanguageProvider>(context, listen: false);
    final cmd = command.trim().toLowerCase();
    
    _addToHistory('sidatt@portfolio:~ \$ $command');
    
    switch (cmd) {
      case 'help':
        _addToHistory(langProvider.getTranslation('terminal_help'));
        break;
      case 'clear':
        setState(() => _history.clear());
        break;
      case 'ls':
        _addToHistory('''drwxr-xr-x  sidatt  users  4096  Jan 10 10:30 .
drwxr-xr-x  sidatt  users  4096  Jan 10 10:30 ..
-rw-r--r--  sidatt  users  2200  Jan 10 10:30 README.md
drwxr-xr-x  sidatt  users  4096  Jan 10 10:30 skills/
drwxr-xr-x  sidatt  users  4096  Jan 10 10:30 projects/
drwxr-xr-x  sidatt  users  4096  Jan 10 10:30 experience/
-rw-r--r--  sidatt  users  1048  Jan 10 10:30 contact.txt
-rw-r--r--  sidatt  users   526  Jan 10 10:30 about.md''');
        break;
      case 'whoami':
        _addToHistory('''Username: sidatt
Full Name: Sidatt Taleb Belkhair
Role: Cybersecurity Student & Developer
Location: Nouakchott, Mauritania
Status: Available for opportunities''');
        break;
      case 'skills':
        _addToHistory('''Technical Skills:
  [Cybersecurity]  Penetration Testing, CTF, DevSecOps, SOC
  [Networking]     VLANs, Routing, SSH, Packet Tracer
  [Monitoring]     Grafana, Loki, Promtail
  [Development]    Java, Python, JS, React, Spring Boot
  [AI/ML]          Scikit-learn, TensorFlow, PyTorch
  [Tools]          Docker, Flutter, PostgreSQL, Linux''');
        break;
      case 'projects':
        final projectList = projects.map((p) => '  - ${p.name} (${p.technologies.join(", ")})').join('\n');
        _addToHistory('Projects:\n$projectList');
        break;
      case 'contact':
        _addToHistory('''Contact Information:
  Email:    belkhairtaleb@gmail.com
  Phone:    +222 32 46 05 18
  GitHub:   github.com/sidattBelkhair
  TryHackMe: tryhackme.com/p/SidattBelkhair
  Location: Nouakchott, Mauritanie''');
        break;
      case 'neofetch':
        _addToHistory('''                   -\`                  sidatt@portfolio
                  .o+\`                 ------------------
                 \`ooo/                 OS: Arch Linux x86_64
                \`+oooo:                Host: Sidatt Belkhair Portfolio
               \`+oooooo:               Kernel: 6.7.0-arch1-1
               -+oooooo+:              Uptime: 2 years, 4 months
             \`/:-:++oooo+:             Packages: 1337 (pacman)
            \`/++++/+++++++:            Shell: zsh 5.9
           \`/++++++++++++++:           Resolution: 1920x1080
          \`/+++ooooooooooooo/\`          DE: Flutter Web
         ./ooosssso++osssssso+\`         WM: Custom Cyber Theme
        .oossssso-\`\`\`/ossssss+\`        Theme: Dark-Hacker
       -osssssso.      :ssssssso.       Icons: Neon-Green
      :osssssss/        osssso+++.      Terminal: sidatt-terminal
     /ossssssss/        +ssssooo/-      CPU: Brain i9-9999K
   \`/ossssso+/:-        -:/+osssso+-    GPU: Neural Network RTX 4090
  \`+sso+:-\`                 \`.-/+oso:   Memory: 16GB RAM / Infinite Curiosity
 \`++:.                           \`-/+/
 .\`                                 \`/''');
        break;
      case 'hack':
        _simulateHack();
        break;
      default:
        if (cmd.startsWith('cat ')) {
          final file = cmd.substring(4).trim();
          _addToHistory(_getFileContent(file));
        } else if (cmd.isNotEmpty) {
          _addToHistory('Command not found: $command. Type "help" for available commands.');
        }
    }
    
    _controller.clear();
  }

  String _getFileContent(String filename) {
    switch (filename) {
      case 'README.md':
        return '# Sidatt Belkhair Portfolio\n\nWelcome to my cybersecurity portfolio!\n\n## About Me\nI am a student specializing in Networks, Systems & Security with experience in monitoring, SOC, pentesting, and development.\n\n## Quick Start\n- Run `skills` to see my technical abilities\n- Run `projects` to view my work\n- Run `contact` to get in touch';
      case 'contact.txt':
        return 'Email: belkhairtaleb@gmail.com\nPhone: +222 32 46 05 18\nGitHub: sidattBelkhair';
      case 'about.md':
        return '# About Sidatt Belkhair\n\nCo-founder of ConnectSoft\nStudent at Institut Supérieur du Numérique\nPassionate about AI & Cybersecurity';
      default:
        return 'cat: $filename: No such file or directory';
    }
  }

  void _simulateHack() async {
    final sequences = [
      'Initializing breach protocol...',
      'Bypassing firewall... [OK]',
      'Decrypting secure handshake... [OK]',
      'Accessing mainframe... [OK]',
      'Downloading data packets... [||||||] 100%',
      'Covering tracks... [OK]',
      'Connection terminated.',
      'Just kidding! This is a portfolio website :)'
    ];
    
    for (final seq in sequences) {
      await Future.delayed(const Duration(milliseconds: 400));
      _addToHistory(seq);
    }
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final size = MediaQuery.of(context).size;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
      child: Column(
        children: [
          Text(
            langProvider.getTranslation('terminal'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              fontFamily: 'JetBrains Mono',
            ),
          ),
          const SizedBox(height: 40),
          Container(
            constraints: const BoxConstraints(maxWidth: 900),
            height: 500,
            decoration: BoxDecoration(
              color: const Color(0xFF0c0c0c),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF333333)),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00ff41).withOpacity(0.1),
                  blurRadius: 30,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                // Terminal Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1a1a1a),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Text(
                          'sidatt@portfolio: ~',
                          style: TextStyle(
                            color: Colors.white70,
                            fontFamily: 'JetBrains Mono',
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                // Terminal Body
                Expanded(
                  child: GestureDetector(
                    onTap: () => _focusNode.requestFocus(),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: _history.length,
                              itemBuilder: (context, index) {
                                return SelectableText(
                                  _history[index],
                                  style: const TextStyle(
                                    color: Color(0xFF00ff41),
                                    fontFamily: 'JetBrains Mono',
                                    fontSize: 13,
                                    height: 1.5,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text(
                                'sidatt@portfolio:~ \$ ',
                                style: TextStyle(
                                  color: Color(0xFF00ff41),
                                  fontFamily: 'JetBrains Mono',
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: RawKeyboardListener(
                                  focusNode: _focusNode,
                                  onKey: (event) {
                                    if (event is RawKeyDownEvent) {
                                      if (event.logicalKey == LogicalKeyboardKey.enter) {
                                        _executeCommand(_controller.text);
                                      }
                                    }
                                  },
                                  child: TextField(
                                    controller: _controller,
                                    style: const TextStyle(
                                      color: Color(0xFF00ff41),
                                      fontFamily: 'JetBrains Mono',
                                      fontSize: 13,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    cursorColor: const Color(0xFF00ff41),
                                    autofocus: true,
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                opacity: _showCursor ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 100),
                                child: Container(
                                  width: 8,
                                  height: 16,
                                  color: const Color(0xFF00ff41),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Tip: Try commands like "neofetch", "skills", "projects", or "hack"',
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontFamily: 'JetBrains Mono',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}