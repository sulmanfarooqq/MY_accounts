import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

// Main entry point for the application
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sulman Farooq - Portfolio',
      home: FuturisticPortfolioPage(),
    );
  }
}

// Data models for background elements
class NebulaParticle {
  Offset position;
  Offset velocity;
  double size;
  final Color color;

  NebulaParticle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.color,
  });
}

class StarParticle {
  Offset position;
  double size;
  double opacity;
  late AnimationController opacityController;

  StarParticle({
    required this.position,
    required this.size,
    required TickerProvider vsync,
  }) : opacity = 0.0 {
    opacityController = AnimationController(
      vsync: vsync,
      duration: Duration(milliseconds: Random().nextInt(3000) + 2000),
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          opacityController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          // Relocate star and restart animation
          position = Offset(
            Random().nextDouble() * 2000, // Assuming a large canvas
            Random().nextDouble() * 2000,
          );
          opacityController.forward();
        }
      })
      ..forward();
  }

  void dispose() {
    opacityController.dispose();
  }
}

class StardustParticle {
  Offset position;
  Offset velocity;
  double size;
  double opacity;

  StardustParticle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.opacity,
  });
}

// Custom painter for the entire cosmic background
class CosmicBackgroundPainter extends CustomPainter {
  final List<NebulaParticle> nebulaParticles;
  final List<StarParticle> starParticles;
  final double planetRotation;
  final Offset parallaxOffset;

  CosmicBackgroundPainter({
    required this.nebulaParticles,
    required this.starParticles,
    required this.planetRotation,
    required this.parallaxOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Apply parallax transformation to the entire canvas for background elements
    canvas.save();
    canvas.translate(parallaxOffset.dx * 0.5, parallaxOffset.dy * 0.5);

    // Draw Dark Planet
    final planetPaint = Paint()..color = const Color(0xFF101020);
    final planetCenter = Offset(size.width * 0.8, size.height * 0.2);
    final planetRadius = size.width * 0.15;
    
    // Planet atmosphere glow
    final atmospherePaint = Paint()
      ..color = const Color(0xFF00D1B2).withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);
    canvas.drawCircle(planetCenter, planetRadius + 15, atmospherePaint);
    
    canvas.save();
    canvas.translate(planetCenter.dx, planetCenter.dy);
    canvas.rotate(planetRotation);
    canvas.translate(-planetCenter.dx, -planetCenter.dy);
    canvas.drawCircle(planetCenter, planetRadius, planetPaint);
    canvas.restore();


    // Draw Nebula effects (large, blurry clouds)
    for (var particle in nebulaParticles) {
      final paint = Paint()
        ..color = particle.color
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);
      canvas.drawCircle(particle.position, particle.size, paint);
    }

    // Draw flickering distant stars
    for (var star in starParticles) {
      final paint = Paint()
        ..color = Colors.white.withOpacity(star.opacityController.value)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);
      canvas.drawCircle(star.position, star.size, paint);
    }
    
    canvas.restore(); // Restore from parallax translation
  }

  @override
  bool shouldRepaint(CosmicBackgroundPainter oldDelegate) => true;
}

// Custom painter for the foreground stardust cascade
class StardustPainter extends CustomPainter {
  final List<StardustParticle> particles;
  final Offset parallaxOffset;
  
  StardustPainter({required this.particles, required this.parallaxOffset});

  @override
  void paint(Canvas canvas, Size size) {
     canvas.save();
     canvas.translate(parallaxOffset.dx * 0.2, parallaxOffset.dy * 0.2);
     
    for (var dust in particles) {
      final paint = Paint()
        ..color = Colors.white.withOpacity(dust.opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);
      canvas.drawCircle(dust.position, dust.size, paint);
    }
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant StardustPainter oldDelegate) => true;
}


class FuturisticPortfolioPage extends StatefulWidget {
  const FuturisticPortfolioPage({super.key});

  @override
  State<FuturisticPortfolioPage> createState() =>
      _FuturisticPortfolioPageState();
}

class _FuturisticPortfolioPageState extends State<FuturisticPortfolioPage>
    with TickerProviderStateMixin {
  // Theme colors from the prompt
  static const cosmicBlack = Color(0xFF0A0A15);
  static const electricViolet = Color(0xFF7B1FA2);
  static const cosmicTeal = Color(0xFF00D1B2);
  static const stardustWhite = Color(0xFFF0F0F0);

  // Animation controller
  late AnimationController _animationController;

  // Background elements
  final List<NebulaParticle> _nebulaParticles = [];
  final List<StarParticle> _starParticles = [];
  final List<StardustParticle> _stardustParticles = [];
  final Random _random = Random();

  // Content-related state
  final String profileImageUrl =
      'https://images.unsplash.com/photo-1535713875002-d1d0cfce54b9?q=80&w=1780&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
  final String name = 'Sulman Farooq';
  final List<String> animatedTitles = [
    'Cinematic Filmmaker',
    'Developer',
    'Photographer',
    'Storyteller',
  ];
  int _currentTitleIndex = 0;
  Timer? _titleTimer;

  // Flicker effect for name
  double _flickerOpacity = 1.0;
  Timer? _flickerTimer;

  // Mouse position for parallax
  Offset _mousePosition = Offset.zero;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(minutes: 5), // A very long duration for slow evolution
    )..addListener(_updateAnimations);
    
    _initializeBackgroundElements();
    _animationController.repeat();

    _titleTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          _currentTitleIndex = (_currentTitleIndex + 1) % animatedTitles.length;
        });
      }
    });

    _flickerTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (mounted) {
        setState(() {
          _flickerOpacity = 0.7 + _random.nextDouble() * 0.3;
        });
      }
    });
  }

  void _initializeBackgroundElements() {
    // Nebula clouds
    _nebulaParticles.addAll([
      NebulaParticle(position: const Offset(200, 300), velocity: const Offset(0.05, 0.03), size: 350, color: electricViolet.withOpacity(0.2)),
      NebulaParticle(position: const Offset(800, 700), velocity: const Offset(-0.04, -0.06), size: 400, color: cosmicTeal.withOpacity(0.2)),
      NebulaParticle(position: const Offset(500, 900), velocity: const Offset(0.02, -0.02), size: 250, color: stardustWhite.withOpacity(0.1)),
    ]);
    
    // Flickering stars
    for (int i = 0; i < 150; i++) {
        _starParticles.add(StarParticle(
            position: Offset(_random.nextDouble() * 2000, _random.nextDouble() * 2000),
            size: _random.nextDouble() * 1.5 + 0.5,
            vsync: this
        ));
    }
    
    // Foreground stardust
    for (int i = 0; i < 100; i++) {
      _stardustParticles.add(StardustParticle(
          position: Offset(_random.nextDouble() * 1000, _random.nextDouble() * 1000),
          velocity: Offset(0, _random.nextDouble() * 1.5 + 0.5),
          size: _random.nextDouble() * 2 + 1,
          opacity: _random.nextDouble() * 0.4 + 0.2,
      ));
    }
  }

  void _updateAnimations() {
     if (!mounted) return;
    setState(() {
      final Size size = MediaQuery.of(context).size;
      // Update Nebula particles
      for (var p in _nebulaParticles) {
        p.position = p.position + p.velocity;
         if (p.position.dx < -p.size) p.position = Offset(size.width + p.size, p.position.dy);
         if (p.position.dx > size.width + p.size) p.position = Offset(-p.size, p.position.dy);
         if (p.position.dy < -p.size) p.position = Offset(p.position.dx, size.height + p.size);
         if (p.position.dy > size.height + p.size) p.position = Offset(p.position.dx, -p.size);
      }
      // Update Stardust particles
      for (var p in _stardustParticles) {
          p.position += p.velocity;
          if (p.position.dy > size.height) {
              p.position = Offset(_random.nextDouble() * size.width, -p.size);
          }
      }
    });
  }

  @override
  void dispose() {
    _titleTimer?.cancel();
    _flickerTimer?.cancel();
    _starParticles.forEach((star) => star.dispose());
    _animationController.removeListener(_updateAnimations);
    _animationController.dispose();
    super.dispose();
  }
  
  void _updateMousePosition(PointerEvent details) {
    if (mounted) {
      setState(() {
        _mousePosition = details.localPosition;
      });
    }
  }
  
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Could add error handling here
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // Calculate parallax offset based on mouse position relative to screen center
    final parallaxOffset = Offset(
      (_mousePosition.dx - size.width / 2) / 20,
      (_mousePosition.dy - size.height / 2) / 20,
    );

    return MouseRegion(
      onHover: _updateMousePosition,
      child: Scaffold(
        backgroundColor: cosmicBlack,
        body: Stack(
          children: [
            // Layer 1: Deep Background (Planet, Nebulae, Stars) with Parallax
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) => CustomPaint(
                painter: CosmicBackgroundPainter(
                  nebulaParticles: _nebulaParticles,
                  starParticles: _starParticles,
                  planetRotation: _animationController.value * 2 * pi,
                  parallaxOffset: parallaxOffset,
                ),
                child: Container(),
              ),
            ),
            
            // Layer 2: Main Content (Scrollable)
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Hero Section
                        _PulsatingProfileImage(
                          animation: _animationController,
                          imageUrl: profileImageUrl,
                        ),
                        const SizedBox(height: 24),
                        Opacity(
                          opacity: _flickerOpacity,
                          child: GlowText(
                            name,
                            style: GoogleFonts.orbitron(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: stardustWhite),
                            glowColor: electricViolet,
                            blurRadius: 15,
                          ),
                        ),
                        const SizedBox(height: 12),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 1000),
                          transitionBuilder: (child, animation) => FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(animation),
                              child: child,
                            ),
                          ),
                          child: Text(
                            animatedTitles[_currentTitleIndex],
                            key: ValueKey<int>(_currentTitleIndex),
                            style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w300,
                                color: cosmicTeal,
                                letterSpacing: 2),
                          ),
                        ),
                        const SizedBox(height: 48),
                        ..._SocialLink.socialLinks.map((link) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: _GlowingSocialBox(
                            link: link,
                            onTap: () => _launchUrl(link.url),
                          ),
                        )).toList(),
                        const SizedBox(height: 120),
                        
                        // Photography Section
                        _SectionTitle(title: 'My Photography'),
                        const SizedBox(height: 16),
                        Text(
                          "Focusing on objects, landscapes, and cinematic composition, I capture stories in stillness.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(color: stardustWhite.withOpacity(0.8), fontSize: 16),
                        ),
                        const SizedBox(height: 40),
                        _PhotographyGallery(),
                        const SizedBox(height: 120),

                        // Development Section
                        _SectionTitle(title: 'My Development Work'),
                         const SizedBox(height: 16),
                         Text(
                          "Building immersive and performant digital experiences with a focus on clean code and great user experience.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(color: stardustWhite.withOpacity(0.8), fontSize: 16),
                        ),
                        const SizedBox(height: 40),
                        Wrap(
                          spacing: 24,
                          runSpacing: 24,
                          alignment: WrapAlignment.center,
                          children: const [
                            _ProjectCard(
                              title: 'Cosmic Portfolio',
                              description: 'An immersive portfolio built with Flutter Web, featuring dynamic animations and interactive elements.',
                              icon: Icons.palette,
                              url: 'https://github.com/sulmanfarooq', // Replace with actual URL
                            ),
                            _ProjectCard(
                              title: 'Data Visualization App',
                              description: 'A cross-platform application for visualizing complex datasets with interactive charts and graphs.',
                              icon: Icons.bar_chart,
                              url: 'https://github.com/sulmanfarooq', // Replace with actual URL
                            ),
                             _ProjectCard(
                              title: 'E-commerce Platform',
                              description: 'A full-stack e-commerce solution with a custom backend and a responsive Flutter frontend.',
                              icon: Icons.shopping_cart,
                              url: 'https://github.com/sulmanfarooq', // Replace with actual URL
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // Layer 3: Foreground Stardust Cascade with Parallax
            AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => IgnorePointer(
                    child: CustomPaint(
                      painter: StardustPainter(
                          particles: _stardustParticles, 
                          parallaxOffset: parallaxOffset),
                      child: Container(),
                    ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

// --- WIDGETS ---

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return GlowText(
      title,
      style: GoogleFonts.orbitron(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: _FuturisticPortfolioPageState.stardustWhite,
      ),
      glowColor: _FuturisticPortfolioPageState.cosmicTeal,
      blurRadius: 10,
    );
  }
}


class _PulsatingProfileImage extends StatefulWidget {
  final Animation<double> animation;
  final String imageUrl;

  const _PulsatingProfileImage({required this.animation, required this.imageUrl});

  @override
  _PulsatingProfileImageState createState() => _PulsatingProfileImageState();
}

class _PulsatingProfileImageState extends State<_PulsatingProfileImage> {
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 15.0, end: 25.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 25.0, end: 15.0), weight: 1),
    ]).animate(CurvedAnimation(
        parent: widget.animation,
        curve: const Interval(0, 0.5, curve: Curves.easeInOut)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return GlowContainer(
          width: 150,
          height: 150,
          glowColor: _FuturisticPortfolioPageState.electricViolet,
          blurRadius: _glowAnimation.value,
          spreadRadius: 5,
          shape: BoxShape.circle,
          child: child!,
        );
      },
      child: CircleAvatar(
        radius: 75,
        backgroundImage: NetworkImage(widget.imageUrl),
      ),
    );
  }
}

class _PhotographyGallery extends StatelessWidget {
  final List<String> photoUrls = [
    'https://images.unsplash.com/photo-1518091042233-285626e33a23?w=500',
    'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=500',
    'https://images.unsplash.com/photo-1542314831-068cd1dbb563?w=500',
    'https://images.unsplash.com/photo-1532298229144-0ec0c57515c7?w=500',
    'https://images.unsplash.com/photo-1507525428034-b723a9ce68ce?w=500',
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: photoUrls.map((url) => _PhotoCard(imageUrl: url)).toList(),
        ),
      ),
    );
  }
}

class _PhotoCard extends StatefulWidget {
  final String imageUrl;
  const _PhotoCard({required this.imageUrl});
  @override
  _PhotoCardState createState() => _PhotoCardState();
}

class _PhotoCardState extends State<_PhotoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _tiltAnimation;
  late Animation<double> _glowAnimation;
  Offset _mousePos = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _tiltAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _glowAnimation = Tween<double>(begin: 0.0, end: 10.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      onHover: (event) => setState(() => _mousePos = event.localPosition),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final tiltX = (_mousePos.dy / 150 - 0.5) * 0.15 * _tiltAnimation.value;
          final tiltY = -(_mousePos.dx / 250 - 0.5) * 0.15 * _tiltAnimation.value;
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(tiltX)
              ..rotateY(tiltY),
            alignment: FractionalOffset.center,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: 250,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _FuturisticPortfolioPageState.cosmicTeal
                        .withOpacity(0.5 * _glowAnimation.value / 10),
                    blurRadius: _glowAnimation.value,
                    spreadRadius: 2,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData? icon;
  final String url;

  const _ProjectCard({
    required this.title,
    required this.description,
    this.icon,
    required this.url,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Offset _mousePos = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      onHover: (event) => setState(() => _mousePos = event.localPosition),
      child: GestureDetector(
        onTap: () async {
          final Uri uri = Uri.parse(widget.url);
          if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
            // Could add error handling here
          }
        },
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final tiltX = (_mousePos.dy / 150 - 0.5) * 0.1 * _animation.value;
            final tiltY = -(_mousePos.dx / 300 - 0.5) * 0.1 * _animation.value;
            return Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(tiltX)
                ..rotateY(tiltY)
                ..scale(1.0 + (0.03 * _animation.value)),
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: _FuturisticPortfolioPageState.cosmicBlack.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: _FuturisticPortfolioPageState.electricViolet.withOpacity(0.3 + 0.5 * _animation.value), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: _FuturisticPortfolioPageState.electricViolet.withOpacity(0.3 * _animation.value),
                      blurRadius: 15 * _animation.value,
                      spreadRadius: 2 * _animation.value,
                    )
                  ],
                ),
                child: child!,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.icon != null)
                Icon(
                  widget.icon!,
                  color: _FuturisticPortfolioPageState.cosmicTeal,
                  size: 32,
                ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: _FuturisticPortfolioPageState.stardustWhite),
              ),
              const SizedBox(height: 8),
              Text(
                widget.description,
                style: GoogleFonts.poppins(fontSize: 14, color: _FuturisticPortfolioPageState.stardustWhite.withOpacity(0.8)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlowingSocialBox extends StatefulWidget {
  final _SocialLink link;
  final VoidCallback onTap;

  const _GlowingSocialBox({
    required this.link,
    required this.onTap,
  });

  @override
  State<_GlowingSocialBox> createState() => _GlowingSocialBoxState();
}

class _GlowingSocialBoxState extends State<_GlowingSocialBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
     _shimmerAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: -1.5, end: 1.5), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  void _onEnter(PointerEvent details) {
     _controller.forward(from: 0);
  }
  
  void _onExit(PointerEvent details) {
    _controller.reverse();
  }

  // Define _launchUrl method within the class
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Could add error handling here
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                 constraints: const BoxConstraints(minWidth: 280, maxWidth: 320),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(12),
                   boxShadow: [
                     BoxShadow(
                       color: widget.link.glowColor.withOpacity(0.5 * _glowAnimation.value),
                       blurRadius: 12 * _glowAnimation.value,
                       spreadRadius: 1,
                     )
                   ]
                 ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withOpacity(0.1 + (0.2 * _glowAnimation.value)))
                      ),
                      child: Stack(
                         children: [
                            // Shimmer Effect
                           Positioned.fill(
                             child: Transform.translate(
                               offset: Offset(150 * _shimmerAnimation.value, 0),
                               child: Container(
                                 decoration: BoxDecoration(
                                   gradient: LinearGradient(
                                     begin: Alignment.centerLeft,
                                     end: Alignment.centerRight,
                                     colors: [
                                       Colors.transparent,
                                       Colors.white.withOpacity(0.3 * _glowAnimation.value),
                                       Colors.transparent,
                                     ],
                                     stops: const [0.4, 0.5, 0.6]
                                   )
                                 ),
                               ),
                             ),
                           ),
                           // Content
                           Row(
                             children: [
                               GlowIcon(
                                 widget.link.icon,
                                 color: Colors.white,
                                 glowColor: widget.link.glowColor,
                                 blurRadius: 15 * _glowAnimation.value,
                                 size: 24,
                               ),
                               const SizedBox(width: 20),
                               Expanded(
                                 child: GlowText(
                                   widget.link.label,
                                   style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                   glowColor: widget.link.glowColor,
                                   blurRadius: 10 * _glowAnimation.value,
                                 ),
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
          },
        ),
      ),
    );
  }
}


class _SocialLink {
  final String label;
  final IconData icon;
  final String url;
  final Color glowColor;

  const _SocialLink({
    required this.label,
    required this.icon,
    required this.url,
    required this.glowColor,
  });

  static List<_SocialLink> socialLinks = const [
    _SocialLink(
      label: 'Instagram',
      icon: FontAwesomeIcons.instagram,
      url: 'https://instagram.com/sulmanfarooq', // Replace with actual URL
      glowColor: Color(0xFFE1306C),
    ),
    _SocialLink(
      label: 'GitHub',
      icon: FontAwesomeIcons.github,
      url: 'https://github.com/sulmanfarooq', // Replace with actual URL
      glowColor: Color(0xFFFFFFFF),
    ),
    _SocialLink(
      label: 'LinkedIn',
      icon: FontAwesomeIcons.linkedin,
      url: 'https://linkedin.com/in/sulmanfarooq', // Replace with actual URL
      glowColor: Color(0xFF0077B5),
    ),
  ];
}