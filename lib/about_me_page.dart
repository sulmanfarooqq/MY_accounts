import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E).withOpacity(0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFD4C7AE)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            tooltip: 'Go Back',
          ),
        ),
        // backgroundColor: const Color(0xFF1E1E1E),
        backgroundColor: Colors.transparent,
        elevation: 0,

        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: true,
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
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: DefaultTextStyle(
              style: textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                height: 1.6,
                color: const Color(0xFFD4C7AE),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      'About Me',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _heading("🎥 Who I Am"),
                  _paragraph(
                      "I'm Sulman Farooq — a photographer, and software engineer. Through visuals and code, I tell stories that feel as real as rain on a window or silence in a dark room."),
                  _heading("🌏 My World"),
                  _paragraph(
                      "Born in kashmir, raised by stories, and inspired by metro stations, abandoned doors, and moody stairs. I’m a hostelite, a content creator, and a dreamer."),
                  _paragraph(
                      "I combine my love for tech with my love for aesthetics — merging a programmer’s logic with a director’s soul."),
                  _heading("🔥 My Passion"),
                  _paragraph(
                      "Cinematic lighting, urban solitude, and vintage feelings — that's what drives me. I’m deeply inspired by Irfan Junejo’s daily life vlogs and BB Ki Vines’ multi-character stories."),
                  _paragraph(
                      "I want to create silent films with reversed timelines, emotional reels, and storytelling that hits even without dialogue."),
                  _heading("🛠️ My Hobbies"),
                  _bullet(
                      "📸 Capturing cinematic shots of metro stations, empty roads, and timeless architecture."),
                  _bullet(
                      "📝 Writing film scripts filled with emotion, suspense, or daily life silence."),
                  _bullet(
                      "🎬 Editing videos with sound, silence, and shadows."),
                  _bullet(
                      "📱 Managing Instagram & sharing shayari, stories, and moments like a digital diary."),
                  _bullet(
                      "🎞️ Planning short films that can be watched forward or backward — both with unique meanings."),
                  _heading("🚀 Looking Ahead"),
                  _paragraph(
                      "I aim to merge creativity with code — building apps that feel like art, and films that feel like dreams."),
                  _paragraph(
                      "My future lies in both the app stores and film festivals. And yes, I’m just getting started."),
                  _heading("🖋️ Final Words"),
                  _paragraph(
                      "I am Sulman Farooq — a silent observer and an artistic creator. I don’t just capture moments — I design feelings."),
                  _paragraph(
                      "If you see a post, a reel, or a poster with a strange calmness — that’s probably mine."),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _heading(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFD4C7AE),
          shadows: const [
            Shadow(
              blurRadius: 10.0,
              color: Color(0xFFE07A5F),
              offset: Offset(0, 0),
            ),
            Shadow(
              blurRadius: 20.0,
              color: Color(0xFFD4C7AE),
              offset: Offset(0, 0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paragraph(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(content),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text("• $text"),
    );
  }
}
