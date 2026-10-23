import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final VoidCallback onClose;
  final VoidCallback onHome;

  const GameOverScreen({
    required this.score,
    required this.totalQuestions,
    required this.onClose,
    required this.onHome,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final int incorrect = (totalQuestions - score).clamp(0, totalQuestions);
    final double percentage = totalQuestions > 0 ? (score / totalQuestions) * 100 : 0.0;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          tooltip: 'Kembali ke kartu soal',
          onPressed: onClose,
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF263238)),
        ),
        title: const Text(
          'Quiz Results',
          style: TextStyle(
            color: Color(0xFF263238),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 420),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x145E35B1),
                    blurRadius: 32,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Celebration illustration
                  Container(
                    width: 110,
                    height: 110,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0x267E57C2),
                          Color(0x0D5E35B1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        '👍',
                        style: TextStyle(fontSize: 54),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Good Job Title
                  Text(
                    percentage >= 60 ? 'Good Job!' : 'Nice Try!',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF263238),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Your Score',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF90A4AE),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Score percentage in large typography
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF5E35B1), Color(0xFF7E57C2)],
                    ).createShader(bounds),
                    child: Text(
                      '${percentage.toInt()}',
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  // 3 Stat Boxes matching Screenshot 5!
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          label: 'Total',
                          value: totalQuestions.toString().padLeft(2, '0'),
                          color: const Color(0xFF2196F3),
                          bgColor: const Color(0xFFE3F2FD),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _StatCard(
                          label: 'Correct',
                          value: score.toString().padLeft(2, '0'),
                          color: const Color(0xFF4CAF50),
                          bgColor: const Color(0xFFE8F5E9),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _StatCard(
                          label: 'Incorrect',
                          value: incorrect.toString().padLeft(2, '0'),
                          color: const Color(0xFFF44336),
                          bgColor: const Color(0xFFFFEBEE),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Play Again / Home button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5E35B1),
                        foregroundColor: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: onHome,
                      icon: const Icon(Icons.home_rounded),
                      label: const Text(
                        'Kembali ke Beranda',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final Color bgColor;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }
}
