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
        icon: Icons.star,
        label: 'Lifestyle Blog',
        url: 'https://example.com/lifestyle'),
    _LinkData(
        icon: FontAwesomeIcons.tiktok,
        label: 'Follow me on TikTok',
        url: 'https://tiktok.com/@skinnedcartree'),
    _LinkData(
        icon: FontAwesomeIcons.twitter,
        label: 'Follow me on Twitter',
        url: 'https://twitter.com/skinnedcartree'),
    _LinkData(
        icon: FontAwesomeIcons.instagram,
        label: 'Follow me on Instagram',
        url: 'https://instagram.com/skinnedcartree'),
    _LinkData(
        icon: Icons.email,
        label: 'email me',
        url: 'mailto:skinnedcartree@example.com'),
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
              '6937351.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Remove animated gradient overlay to avoid overlaying background image
          // Positioned.fill(
          //   child: AnimatedBuilder(
          //     animation: _controller,
          //     builder: (context, child) {
          //       return Container(
          //         decoration: BoxDecoration(
          //           gradient: LinearGradient(
          //             colors: [
          //               Colors.deepPurple.shade900.withOpacity(0.6),
          //               Colors.deepPurple.shade700.withOpacity(0.6),
          //               Colors.teal.shade900.withOpacity(0.6),
          //               Colors.teal.shade700.withOpacity(0.6),
          //             ],
          //             begin: Alignment.topLeft,
          //             end: Alignment.bottomRight,
          //             stops: [
          //               (_controller.value - 0.3).clamp(0.0, 1.0),
          //               (_controller.value - 0.1).clamp(0.0, 1.0),
          //               (_controller.value + 0.1).clamp(0.0, 1.0),
          //               (_controller.value + 0.3).clamp(0.0, 1.0),
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
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
              label: 'Profile picture of Corinne',
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
              'Corinne',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '@skinnedcartree',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white70,
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
    final backgroundColor = _hovering ? Colors.teal.shade700 : Colors.black87;
    final shadow = _hovering
        ? <BoxShadow>[
            BoxShadow(
              color: Colors.tealAccent.withOpacity(0.6),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            )
          ]
        : <BoxShadow>[];

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
                  ? LinearGradient(
                      colors: [Colors.teal.shade600, Colors.teal.shade900],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
            ),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            child: Row(
              children: [
                Icon(widget.icon, color: Colors.tealAccent, size: 24),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    widget.label,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
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
