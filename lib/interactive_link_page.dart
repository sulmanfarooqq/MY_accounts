import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class InteractiveLinkPage extends StatefulWidget {
  const InteractiveLinkPage({Key? key}) : super(key: key);

  @override
  State<InteractiveLinkPage> createState() => _InteractiveLinkPageState();
}

class _InteractiveLinkPageState extends State<InteractiveLinkPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<_LinkData> _links = [
    _LinkData(
        icon: FontAwesomeIcons.instagram,
        label: 'Follow me on Instagram',
        url: 'https://instagram.com/sulmanfarooqq'),
    _LinkData(
        icon: FontAwesomeIcons.github,
        label: 'Follow me on GitHub',
        url: 'https://github.com/sulmanfarooqq'),
    _LinkData(
        icon: FontAwesomeIcons.linkedin,
        label: 'Connect on LinkedIn',
        url: 'https://linkedin.com/in/sulmanfarooqq'),
    _LinkData(
        icon: FontAwesomeIcons.twitter,
        label: 'Follow me on X',
        url: 'https://twitter.com/sulmanfarooqq'),
    _LinkData(
        icon: Icons.email,
        label: 'Email me',
        url: 'mailto:sulmanfarooqq@example.com'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/back(1).jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Snow effect overlay
          const Positioned.fill(
            child: SnowEffect(),
          ),
          // Content
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 40),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ProfileHeader(),
                          const SizedBox(height: 32),
                          ..._links
                              .map((link) => LinkButton(
                                    icon: link.icon,
                                    label: link.label,
                                    onTap: () => _launchUrl(link.url),
                                  ))
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key? key}) : super(key: key);

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final scale = _hovering ? 1.05 : 1.0;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Column(
          children: [
            Semantics(
              label: 'Profile picture of sulmanfarooqq',
              child: CircleAvatar(
                radius: 60,
                backgroundImage: const AssetImage('hero-banner.jpg'),
                // Add subtle shadow
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'sulmanfarooqq',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF3B2F2F), // Dark Brown primary text color
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '@sulmanfarooqq',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color:
                    const Color(0xFFD4C7AE), // Muted Beige secondary text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LinkButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const LinkButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  State<LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<LinkButton> {
  bool _hovering = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scale = _hovering ? 1.03 : (_pressed ? 0.97 : 1.0);
    final backgroundColor =
        _hovering ? const Color(0xFFE07A5F) : const Color(0xFF3B2F2F);
    final shadow = _hovering
        ? <BoxShadow>[
            BoxShadow(
              color: const Color(0xFFE07A5F).withOpacity(0.6),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            )
          ]
        : <BoxShadow>[];

    final textColor = _hovering ? Colors.white : const Color(0xFF3B2F2F);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() {
          _hovering = false;
          _pressed = false;
        }),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapUp: (_) {
            setState(() => _pressed = false);
            widget.onTap();
          },
          onTapCancel: () => setState(() => _pressed = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            transform: Matrix4.identity()..scale(scale),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: shadow,
              gradient: _hovering
                  ? const LinearGradient(
                      colors: [Color(0xFFE07A5F), Color(0xFFC4A484)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            child: Row(
              children: [
                Icon(widget.icon, color: const Color(0xFFC4A484), size: 24),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    widget.label,
                    style: GoogleFonts.poppins(
                      color: _hovering ? Colors.white : Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedBackground extends StatelessWidget {
  final AnimationController controller;

  const AnimatedBackground({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple.shade900,
                Colors.deepPurple.shade700,
                Colors.teal.shade900,
                Colors.teal.shade700,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                (controller.value - 0.3).clamp(0.0, 1.0),
                (controller.value - 0.1).clamp(0.0, 1.0),
                (controller.value + 0.1).clamp(0.0, 1.0),
                (controller.value + 0.3).clamp(0.0, 1.0),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LinkData {
  final IconData icon;
  final String label;
  final String url;

  _LinkData({required this.icon, required this.label, required this.url});
}

class SnowEffect extends StatefulWidget {
  const SnowEffect({Key? key}) : super(key: key);

  @override
  State<SnowEffect> createState() => _SnowEffectState();
}

class _SnowEffectState extends State<SnowEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Snowflake> _snowflakes = [];

  final int _numSnowflakes = 100;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    for (int i = 0; i < _numSnowflakes; i++) {
      _snowflakes.add(_Snowflake.random());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _SnowPainter(_snowflakes, _controller.value),
          child: Container(),
        );
      },
    );
  }
}

class _Snowflake {
  Offset position;
  double radius;
  double speed;
  double swayAmplitude;
  double swayFrequency;
  double initialSwayPhase;

  _Snowflake({
    required this.position,
    required this.radius,
    required this.speed,
    required this.swayAmplitude,
    required this.swayFrequency,
    required this.initialSwayPhase,
  });

  factory _Snowflake.random() {
    final random = Random();
    return _Snowflake(
      position: Offset(random.nextDouble(), random.nextDouble()),
      radius: 1 + random.nextDouble() * 2,
      speed: 0.01 + random.nextDouble() * 0.02,
      swayAmplitude: 0.01 + random.nextDouble() * 0.02,
      swayFrequency: 1 + random.nextDouble() * 3,
      initialSwayPhase: random.nextDouble() * 2 * 3.1415926535897932,
    );
  }

  Offset getPosition(double animationValue) {
    final dx = position.dx +
        swayAmplitude *
            sin(swayFrequency * animationValue * 2 * 3.1415926535897932 +
                initialSwayPhase);
    final dy = (position.dy + speed * animationValue) % 1.0;
    return Offset(dx, dy);
  }
}

class _SnowPainter extends CustomPainter {
  final List<_Snowflake> snowflakes;
  final double animationValue;

  _SnowPainter(this.snowflakes, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.8);

    for (final snowflake in snowflakes) {
      final pos = snowflake.getPosition(animationValue);
      final offset = Offset(pos.dx * size.width, pos.dy * size.height);
      canvas.drawCircle(offset, snowflake.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _SnowPainter oldDelegate) {
    return true;
  }
}
