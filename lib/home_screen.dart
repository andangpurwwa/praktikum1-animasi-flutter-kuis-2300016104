import 'package:flutter/material.dart';

import 'question_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showFeatureDialog(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String description,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          icon: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFEDE7F6),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF5E35B1), size: 36),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF263238),
            ),
          ),
          content: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF546E7A),
              height: 1.45,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF5E35B1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const QuestionScreen(),
                  ),
                );
              },
              child: const Text('Coba Sekarang (Mulai Kuis)'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEDE7F6),
              Color(0xFFF5F6FA),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 420),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x145E35B1),
                      blurRadius: 32,
                      offset: Offset(0, 12),
                    ),
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // App Logo with layered glowing effect
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF7E57C2), Color(0xFF5E35B1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x595E35B1),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          '✏️',
                          style: TextStyle(fontSize: 46),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    // App Title
                    Text(
                      'Flutter Quiz',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF263238),
                            letterSpacing: -0.5,
                          ),
                    ),
                    const SizedBox(height: 10),
                    // Subtitle
                    Text(
                      'Uji pemahaman Anda tentang animasi lanjutan di Flutter dengan kuis interaktif.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF78909C),
                            height: 1.45,
                          ),
                    ),
                    const SizedBox(height: 28),
                    // Interactive Feature highlights chips (bisa di-klik!)
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3E5F5),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _FeatureBadge(
                            icon: Icons.bolt,
                            label: 'Animasi Skor',
                            onTap: () => _showFeatureDialog(
                              context,
                              title: 'Animasi Skor (Implisit)',
                              icon: Icons.bolt,
                              description:
                                  'Ikon petir menggunakan AnimatedScale dan ColorTween dengan efek elastic bounce saat jawaban benar!',
                            ),
                          ),
                          _FeatureBadge(
                            icon: Icons.flip,
                            label: 'Card Flip',
                            onTap: () => _showFeatureDialog(
                              context,
                              title: 'Efek 3D Card Flip',
                              icon: Icons.flip,
                              description:
                                  'Pilihan jawaban berputar dalam ruang 3D menggunakan Matrix4 saat soal baru dimuat.',
                            ),
                          ),
                          _FeatureBadge(
                            icon: Icons.swap_horiz,
                            label: 'Page Transition',
                            onTap: () => _showFeatureDialog(
                              context,
                              title: 'PageTransitionSwitcher',
                              icon: Icons.swap_horiz,
                              description:
                                  'Transisi kartu soal dengan efek FadeThroughTransition yang halus dari package animations.',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),
                    // Start Button (Tombol Utama)
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5E35B1),
                          foregroundColor: Colors.white,
                          elevation: 6,
                          shadowColor: const Color(0x665E35B1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuestionScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.play_arrow_rounded, size: 28),
                        label: const Text(
                          'New Game',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _FeatureBadge({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 22, color: const Color(0xFF5E35B1)),
              const SizedBox(height: 5),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4527A0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
