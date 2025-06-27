import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Me'),
        backgroundColor: const Color(0xFFE07A5F),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/back(1).jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: DefaultTextStyle(
              style: textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                height: 1.5,
                color: Colors.white, // use this color 0xFFD4C7AE
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Who I Am: The Story of Sulman Farooq',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'In the heart of every artist lies a unique story—one woven with vision, ambition, and an unstoppable creative fire. My name is Sulman Farooq, and I am more than just a photographer, filmmaker, or a software engineer—I am a storyteller. Whether it’s through a lens, a line of code, or a social media caption, I create to connect, to inspire, and to document the world around me in its most raw and beautiful forms.',
                  ),
                  SizedBox(height: 24),
                  Text(
                    'A Glimpse Into My World',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'I hail from Pakistan, where culture, architecture, and human emotion blend into stories waiting to be captured. I\'m a content creator, a hostelite, and a passionate cinematic videographer whose heart beats faster at the sight of moody lighting, metro stairs, rainy windows, or an old forgotten door with history etched into its cracks.',
                  ),
                  SizedBox(height: 12),
                  Text(
                    'But my identity isn’t confined to visuals alone—I am also a software engineer by education and an explorer of the digital world by profession. I bring together the logical mind of a coder and the soulful heart of an artist to design not only software solutions but also immersive, emotionally charged visual content.',
                  ),
                  SizedBox(height: 24),
                  Text(
                    'What Drives Me: My Passion',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'At the center of my being lies a burning passion for filmmaking and aesthetic storytelling. I’m inspired by creators like Irfan Junejo and BB Ki Vines, who master the art of turning everyday life into compelling visual narratives. Just like them, I want to tell stories—whether it\'s through silent short films, self-dialogue-based skits, or Instagram reels that spark emotion in just 30 seconds.',
                  ),
                  SizedBox(height: 12),
                  Text(
                    'I\'m obsessed with cinematic tones, low-light captures, moody photography, and vintage aesthetics. When I look through a lens, I don’t just capture a frame—I frame a feeling. I see a staircase and imagine a dramatic escape. I see a bus stand and feel the layers of life passing by in silence.',
                  ),
                  SizedBox(height: 12),
                  Text(
                    'My dream is to not just make content, but to leave a mark—to create a silent short film series where each part can be watched forward or backward, giving two completely different meanings. For me, it’s not just about content—it’s about experience, emotion, and art.',
                  ),
                  SizedBox(height: 24),
                  Text(
                    'My Hobbies: Where My Soul Rests',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'When I’m not writing code or planning cinematic shots, you’ll find me:',
                  ),
                  SizedBox(height: 8),
                  Text(
                      '📷 Taking moody, cinematic photos of metro stations, empty roads, and architectural marvels.'),
                  Text(
                      '✍️ Writing film scripts and storyboards—especially those inspired by daily life, often silent but full of depth.'),
                  Text(
                      '🎬 Editing videos, adding perfect soundscapes and color grades that make moments feel timeless.'),
                  Text(
                      '📱 Managing my social media accounts (like Instagram and soon, Twitter) where I plan to share aesthetic posts, Urdu shayari, and thoughts like a digital diary.'),
                  Text(
                      '🎞️ Thinking up new ideas for silent horror or suspense dramas shot in small rooms, with a twist that can turn even a 1-minute video into a masterpiece.'),
                  SizedBox(height: 24),
                  Text(
                    'Looking Ahead',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'As a student, a creator, and a visionary, I know my journey is only just beginning. I dream of building a future where I can combine technology and creativity—perhaps by developing mobile apps that tell stories or creating tools for artists like me.',
                  ),
                  SizedBox(height: 12),
                  Text(
                    'I also aim to keep improving my filmmaking craft, sharing more on platforms like Instagram, and expanding to YouTube and Twitter, not just for growth, but to connect with people who feel what I feel and see the world the way I see it.',
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Final Words',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'I am Sulman Farooq—a silent observer, a passionate dreamer, and a creator of moods. I believe that even the most ordinary moments can become magical when seen through the right eyes. I don’t just want to make content. I want to create art. I want to tell stories. I want to be remembered.',
                  ),
                  SizedBox(height: 12),
                  Text(
                    'So, if you ever come across one of my reels, photos, or scripts—know that behind that frame is a soul who sees the world not as it is, but as it *feels*.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
