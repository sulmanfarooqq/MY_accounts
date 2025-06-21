import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SimpleLinkPage extends StatelessWidget {
  const SimpleLinkPage({Key? key}) : super(key: key);

  // Helper method to build each button
  Widget _buildLinkButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          minimumSize: const Size(double.infinity, 50),
          padding: const EdgeInsets.symmetric(horizontal: 20),
        ),
        icon: Icon(icon, color: Colors.tealAccent, size: 24),
        label: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a Container with a watercolor pastel background
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('hero-banner.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Circular profile image
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('hero-banner.jpg'),
                ),
                const SizedBox(height: 16),
                // Name
                const Text(
                  'Corinne',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                // Handle
                const Text(
                  '@skinnedcartree',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 32),
                // Buttons
                _buildLinkButton(
                  icon: Icons.star,
                  text: 'Lifestyle Blog',
                  onPressed: () {
                    // TODO: Add link action
                  },
                ),
                _buildLinkButton(
                  icon: FontAwesomeIcons.tiktok,
                  text: 'Follow me on TikTok',
                  onPressed: () {
                    // TODO: Add link action
                  },
                ),
                _buildLinkButton(
                  icon: FontAwesomeIcons.twitter,
                  text: 'Follow me on Twitter',
                  onPressed: () {
                    // TODO: Add link action
                  },
                ),
                _buildLinkButton(
                  icon: FontAwesomeIcons.instagram,
                  text: 'Follow me on Instagram',
                  onPressed: () {
                    // TODO: Add link action
                  },
                ),
                _buildLinkButton(
                  icon: Icons.email,
                  text: 'email me',
                  onPressed: () {
                    // TODO: Add link action
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
