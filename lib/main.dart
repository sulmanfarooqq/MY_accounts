import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF7C3AED), // Violet
        onPrimary: Colors.white,
        secondary: Color(0xFF00D1B2), // Turquoise
        onSecondary: Colors.white,
        background: Color(0xFF1E1E2F),
        onBackground: Colors.white,
        surface: Color(0xFF2C2C3C), // Card background
        onSurface: Colors.white,
        error: Colors.red,
        onError: Colors.white,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFF1E1E2F),
      cardColor: const Color(0xFF2C2C3C),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Color(0xFFA0A0B0)), // Muted text
        bodyLarge: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00D1B2), // Turquoise
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24), // 2xl rounded corners
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shadowColor: Colors.black54,
          elevation: 6,
        ),
      ),
      cardTheme: const CardTheme(
        color: Color(0xFF2C2C3C),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        margin: EdgeInsets.all(16),
      ),
    );

    return MaterialApp(
      title: 'Sulman Farooq Portfolio',
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  final String whatsappUrl =
      'https://wa.me/yourwhatsappnumber'; // Replace with your WhatsApp number in international format without +
  final String emailUrl =
      'mailto:youremail@example.com'; // Replace with your email

  final Map<String, String> socialLinks = {
    'Instagram': 'https://instagram.com/sulmanfarooq',
    'YouTube': 'https://youtube.com/@sulmanfarooq',
    'GitHub': 'https://github.com/sulmanfarooq',
    'LinkedIn': 'https://linkedin.com/in/sulmanfarooq',
    'Twitter': 'https://twitter.com/sulman_farooq',
    'Facebook': 'https://facebook.com/sulmanfarooq',
    'Direct.me': 'https://direct.me/sulmanfarooq',
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Open WhatsApp chat or fallback to email
          _launchUrl(whatsappUrl);
        },
        icon: const Icon(Icons.message),
        label: const Text('Message Me'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/12345678?v=4',
                    ), // Replace with your profile image URL or use AssetImage if you add asset
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 16),

                  // Name
                  const Text(
                    'Sulman Farooq',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7C3AED), // Violet
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Animated Header
                  ScaleTransition(
                    scale: _animation,
                    child: const Text(
                      'Cinematic Creator | Developer | Storyteller',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFFA0A0B0), // Muted text
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Bio
                  const Text(
                    'I’m a cinematic filmmaker, editor, and software engineer passionate about old aesthetics, object photography, and storytelling. I create silent short films, suspense thrillers, and Instagram reels with a dramatic and emotional edge. Currently exploring front-end and back-end development with a focus on mobile apps (Flutter), data science, and creative storytelling using minimal resources.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFA0A0B0),
                    ), // Muted text
                  ),
                  const SizedBox(height: 24),

                  // Social Media Buttons
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children:
                        socialLinks.entries.map((entry) {
                          final name = entry.key;
                          final url = entry.value;
                          final color = _getSocialColor(name);
                          final icon = _getSocialIcon(name);
                          return ElevatedButton.icon(
                            onPressed: () => _launchUrl(url),
                            icon: Icon(icon),
                            label: Text(name),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: color,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              shadowColor: Colors.black54,
                              elevation: 6,
                            ),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 32),

                  // Work / Projects Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'My Work',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7C3AED), // Violet
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '• Cinematic short films and suspense thrillers.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFA0A0B0),
                        ), // Muted text
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• Instagram reels with dramatic and emotional storytelling.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFA0A0B0),
                        ), // Muted text
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• Software engineering projects focusing on Flutter and data science.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFA0A0B0),
                        ), // Muted text
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getSocialColor(String name) {
    switch (name) {
      case 'Instagram':
        return const Color(0xFFE1306C);
      case 'YouTube':
        return const Color(0xFFFF0000);
      case 'GitHub':
        return Colors.black;
      case 'LinkedIn':
        return const Color(0xFF0077B5);
      case 'Twitter':
        return const Color(0xFF1DA1F2);
      case 'Facebook':
        return const Color(0xFF1877F2);
      case 'Direct.me':
        return const Color(0xFF00BFFF);
      default:
        return Colors.grey;
    }
  }

  IconData _getSocialIcon(String name) {
    switch (name) {
      case 'Instagram':
        return Icons.camera_alt;
      case 'YouTube':
        return Icons.ondemand_video;
      case 'GitHub':
        return Icons.code;
      case 'LinkedIn':
        return Icons.business;
      case 'Twitter':
        return Icons.alternate_email;
      case 'Facebook':
        return Icons.facebook;
      case 'Direct.me':
        return Icons.link;
      default:
        return Icons.link;
    }
  }
}
